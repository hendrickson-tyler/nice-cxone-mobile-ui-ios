//
// Copyright (c) 2021-2023. NICE Ltd. All rights reserved.
//
// Licensed under the NICE License;
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    https://github.com/nice-devone/nice-cxone-mobile-ui-ios/blob/main/LICENSE
//
// TO THE EXTENT PERMITTED BY APPLICABLE LAW, THE CXONE MOBILE SDK IS PROVIDED ON
// AN “AS IS” BASIS. NICE HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS
// OR IMPLIED, INCLUDING (WITHOUT LIMITATION) WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE, NON-INFRINGEMENT, AND TITLE.
//

import AVFoundation
import Kingfisher
import SwiftUI

struct VideoMessageCell: View {

    // MARK: - Properties
    
    @ObservedObject private var viewModel: VideoMessageCellViewModel

    @EnvironmentObject private var style: ChatStyle

    @Environment(\.colorScheme) var colorScheme
    
    @State private var isSelected: Bool = false
    @State private var isVideoSheetVisible = false
    
    private let isMultiAttachment: Bool
    private let message: ChatMessage

    private var width: CGFloat {
        UIScreen.main.messageCellWidth
    }
    
    // MARK: - Init
    
    init(message: ChatMessage, item: AttachmentItem, isMultiAttachment: Bool) {
        self.message = message
        self.isMultiAttachment = isMultiAttachment
        self.viewModel = VideoMessageCellViewModel(item: item)
    }
    
    // MARK: - Builder
    
    var body: some View {
        ZStack(alignment: message.user.isAgent ? .bottomLeading : .bottomTrailing) {
            thumbnail
                .frame(width: !isMultiAttachment ? width : MultipleAttachmentContainer.cellDimension, height: MultipleAttachmentContainer.cellDimension)
                .scaledToFill()
                .overlay(
                    thumbnailOverlay
                        .imageScale(.large)
                        .foregroundColor(style.backgroundColor.opacity(0.5))
                        .colorInvert()
                        .padding(10)
                        .background(
                            Circle()
                                .fill(style.backgroundColor.opacity(0.5))
                        )
                )
                .sheet(isPresented: $isVideoSheetVisible) {
                    if let videoURL = viewModel.cachedVideoURL {
                        VideoPlayerContainer(videoUrl: videoURL, isPresented: $isVideoSheetVisible)
                    }
                }
                .onTapGesture {
                    isVideoSheetVisible = true
                }
                .if(!isMultiAttachment) { view in
                    view.shareable(message, attachments: [viewModel.item], spacerLength: 0)
                }
        }
    }
}

// MARK: - Subviews

private extension VideoMessageCell {
    
    @ViewBuilder
    var thumbnail: some View {
        if let thumbnail = getThumbnail() {
            thumbnail
                .resizable()
        } else {
            RoundedRectangle(cornerRadius: 12)
        }
    }
    
    @ViewBuilder
    var thumbnailOverlay: some View {
        if isVideoSheetVisible {
            Asset.Attachment.videoInFullScreen
        } else {
            Asset.Attachment.play
        }
    }
}

// MARK: - Private methods

private extension VideoMessageCell {
    
    func getThumbnail() -> Image? {
        guard let videoURL = viewModel.cachedVideoURL else {
            return nil
        }
        let asset = AVAsset(url: videoURL)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        assetImgGenerate.maximumSize = CGSize(width: width, height: MultipleAttachmentContainer.cellDimension)
        
        do {
            let img = try assetImgGenerate.copyCGImage(at: CMTimeMakeWithSeconds(1.0, preferredTimescale: 600), actualTime: nil)
            
            return Image(uiImage: UIImage(cgImage: img))
        } catch {
            error.logError()
            
            return nil
        }
    }
}

// MARK: - Preview

struct VideoMessageCell_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            VStack(spacing: 4) {
                VideoMessageCell(message: MockData.videoMessage(user: MockData.agent), item: MockData.videoItem, isMultiAttachment: false)

                VideoMessageCell(message: MockData.videoMessage(user: MockData.customer), item: MockData.videoItem, isMultiAttachment: false)
            }
            .previewDisplayName("Light Mode")

            VStack(spacing: 4) {
                VideoMessageCell(message: MockData.videoMessage(user: MockData.agent), item: MockData.videoItem, isMultiAttachment: false)

                VideoMessageCell(message: MockData.videoMessage(user: MockData.customer), item: MockData.videoItem, isMultiAttachment: false)
            }
            .previewDisplayName("Dark Mode")
            .preferredColorScheme(.dark)
        }
        .environmentObject(ChatStyle())
    }
}
