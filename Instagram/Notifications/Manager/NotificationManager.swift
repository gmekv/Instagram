//
//  NotificationManagers.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 17.08.24.
//

import Foundation

class NotificationManager {
    
    static let shared = NotificationManager()
    private let service = NotificaitonService()
    
    private init() {} 
    
    func uploadNotification(toUid uid: String, post: Post) {
        service.uploadNotification(toUid: uid, type: .like)
    }
    
    func uploadCOmmentNotification(toUid uid: String, post: Post) {
        service.uploadNotification(toUid: uid, type: .comment, post: post)
    }
    
    func uploadFollowNotification(toUid uid: String) {
        service.uploadNotification(toUid: uid, type: .follow)
    }
    
}
