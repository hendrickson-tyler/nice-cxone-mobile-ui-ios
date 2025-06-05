//
// Copyright (c) 2021-2025. NICE Ltd. All rights reserved.
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

import SwiftUI

struct CustomButton: View {
    
    // MARK: - Properties
    
    private let configuration: ButtonStyleConfiguration
    private let foregroundColor: Color
    private let backgroundColor: Color
    
    private static let horizontalPadding: CGFloat = 16
    private static let backgroundCornerRadius: CGFloat = 8
    private static let pressedOpacity: Double = 0.8
    
    // MARK: - Init
    
    init(configuration: ButtonStyleConfiguration, foregroundColor: Color, backgroundColor: Color) {
        self.configuration = configuration
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
    }
    
    // MARK: - Body
    
    var body: some View {
        configuration.label
            .font(.body.weight(.bold))
            .adjustForA11y()
            .padding(.horizontal, Self.horizontalPadding)
            .foregroundColor(foregroundColor)
            .background(
                RoundedRectangle(cornerRadius: Self.backgroundCornerRadius)
                    .fill(
                        configuration.isPressed
                            ? backgroundColor.opacity(Self.pressedOpacity)
                            : backgroundColor
                    )
            )
    }
}

// MARK: - Preview

private struct PreviewButtonStyle: ButtonStyle {
    
    // MARK: - Builder
    
    func makeBody(configuration: Configuration) -> some View {
        CustomButton(
            configuration: configuration,
            foregroundColor: .white,
            backgroundColor: .accentColor
        )
    }
}

#Preview {
    Button("Button") { }
        .padding()
        .buttonStyle(PreviewButtonStyle())
}
