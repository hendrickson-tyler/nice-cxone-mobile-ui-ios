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

import Foundation

/// Object for a List picker message cell
///
/// This struct is designed for representing list picker items, 
/// which are commonly used in user interfaces to present a list of selectable options.
/// The `elements` array allows you to specify the available choices,
/// making it suitable for various scenarios where users need to make selections from a list.
///
/// ## Example
/// ```
/// let options = [
///     .button(RichMessageButton(title: Lorem.words(nbWords: Int.random(in: 1..<3)), iconUrl: iconUrl))
/// ]
///
/// let item = ListPickerItem(title: Lorem.word(), message: Lorem.sentence(), elements: options)
/// ```
public struct ListPickerItem: Hashable {
    
    // MARK: - Properties
    
    /// The title or label associated with the list picker item.
    public let title: String
    
    /// An optional message or description providing additional context for the item.
    public let message: String?
    
    /// An array of `RichMessageSubElementType` objects, representing the elements available for selection within the list picker.
    public let elements: [RichMessageSubElementType]
    
    // MARK: - Init
    
    /// Initialization of the ListPickerItem
    ///
    /// - Parameters:
    ///  - title: The title or label associated with the list picker item.
    ///  - message: An optional message or description providing additional context for the item.
    ///  - elements: An array of `RichMessageSubElementType` objects, representing the elements available for selection within the list picker.
    public init(title: String, message: String?, elements: [RichMessageSubElementType]) {
        self.title = title
        self.message = message
        self.elements = elements
    }
}
