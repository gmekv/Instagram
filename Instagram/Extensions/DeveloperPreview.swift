//
//  DeveloperPreview.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 10.07.24.
//

import SwiftUI
import Firebase

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}


class DeveloperPreview {
    static let shared = DeveloperPreview()
    let comment = Comment(postIwnerUiD: "123", commentText: "test", postID: "32112", timestamp: Timestamp() , commentOnwerUid: "1242234")
    let notifications: [Notification] = [
        .init(id: NSUUID().uuidString, timestamp: Timestamp(), notificationSenderUid: "123", type: .like),
        .init(id: NSUUID().uuidString, timestamp: Timestamp(), notificationSenderUid: "123", type: .like),
        .init(id: NSUUID().uuidString, timestamp: Timestamp(), notificationSenderUid: "123", type: .like)

    ]
}
