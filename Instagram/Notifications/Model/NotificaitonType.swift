//
//  NotificaitonType.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 17.08.24.
//

import Foundation

enum NotificaitonType: Int, Codable {
    case like
    case comment
    case follow
    
    var notificationMessage: String {
        switch self {
        case .like:
            return "liked one of your posts."
        case .comment:
            return "commented on your post."
        case .follow:
            return "started following you."
        }
    }
}
