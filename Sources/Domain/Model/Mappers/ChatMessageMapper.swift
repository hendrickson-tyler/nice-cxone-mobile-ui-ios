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

import CXoneChatSDK
import Foundation

enum ChatMessageMapper {
    
    static func map(_ message: Message, localization: ChatLocalization) -> ChatMessage {
        let user = message.direction == .toClient
            ? ChatUserMapper.map(from: message.authorUser)
            : ChatUserMapper.map(from: message.authorEndUserIdentity)
        
        return ChatMessage(
            id: message.id,
            user: user,
            types: ChatMessageTypeMapper.map(message, localization: localization),
            date: message.createdAt,
            status: message.status
        )
    }
}
