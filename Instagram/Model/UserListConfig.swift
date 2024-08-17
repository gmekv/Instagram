//
//  UserListConfig.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 04.08.24.
//

import Foundation

enum UserListConfig: Hashable {
    case followers(uid: String)
    case following(uid: String)
    case likes(postId: String)
    case explore
    
    var navigationtitle: String {
        switch self {
        case .followers:
            return "Followers"
        case .following:
            return "Following"
        case .likes:
            return "Likes"
        case .explore:
            return "Explore"
        }
    }
}
