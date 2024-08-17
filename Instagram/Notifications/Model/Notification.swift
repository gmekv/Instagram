//
//  Notification.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 17.08.24.
//

import Firebase

struct Notification: Identifiable, Codable {
    let id: String
    var postID: String?
    let timestamp: Timestamp
    let notificationSenderUid: String
    let type: NotificaitonType
    
    var post: Post?
    var user: User?
}
