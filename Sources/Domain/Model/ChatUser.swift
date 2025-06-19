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

import Foundation

/// Protocol that defines the properties and requirements for a chat user within a chat interface
///
/// This protocol is designed to standardize the representation of chat users,
/// allowing you to create user objects with unique identifiers, usernames, profile images,
/// and a sender flag to distinguish message senders within a chat interface.
public struct ChatUser: Identifiable, Equatable {

    // MARK: - Properties
    
    /// A unique identifier for the chat user.
    public let id: String
    
    /// The display name or username of the chat user.
    public var userName: String?

    /// An optional URL for the user's avatar or profile picture.
    public var avatarURL: URL?
    
    /// A constant property indicating that the chat user is or not the chat agent.
    public let isAgent: Bool
    
    // MARK: - Init
    
    /// Initialization of the ChatUser
    ///
    /// - Parameters:
    ///   - id: A unique identifier for the chat user.
    ///   - userName: The display name or username of the chat user.
    ///   - avatarURL: An optional URL for the user's avatar or profile picture.
    public init(id: String, userName: String?, avatarURL: URL?, isAgent: Bool) {
        self.id = id
        self.userName = userName
        self.avatarURL = avatarURL
        self.isAgent = isAgent
    }
}

// MARK: - Helpers

extension ChatUser {
    
    var initials: String? {
        guard let userName, !userName.isEmpty else {
            return nil
        }
        
        // Remove quoted substrings
        let pattern = "\"[^\"]*\""
        let cleaned = userName.replacingOccurrences(of: pattern, with: "", options: .regularExpression)
        let words = cleaned
            .split(separator: " ")
            .filter { !$0.isEmpty }
        
        // Safely get the first word and its initial; return empty if not available
        guard let first = words.first, let firstInitial = first.first else {
            return ""
        }
        
        // Single-word username: use only the first initial
        if words.count == 1 {
            return String(firstInitial).uppercased()
        }
        
        // Ensure there's at least one word and get its initial
        guard let last = words.last, let lastInitial = last.first else {
            return ""
        }
        return (String(firstInitial) + String(lastInitial)).uppercased()
    }
}
