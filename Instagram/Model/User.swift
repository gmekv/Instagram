//
//  User.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 27.05.24.
//
import Firebase
import Foundation
import FirebaseAuth

struct User: Identifiable, Codable, Hashable {
    let id: String
    var username: String
    var profileImageURL: String?
    var fullname: String?
    var bio: String?
    let email: String
    
    var isFollowed: Bool? = false
    var stats: UserStats?
    
    var isCurrentUser: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        return currentUid == id
    }
}

struct UserStats: Codable, Hashable {
    var followingCount: Int
    var follwersCount: Int
    var postsCount: Int
}


extension User {
    static var mock_Users: [User] {
        [
            User(id: NSUUID().uuidString, username: "nightWatcher", profileImageURL: "batman-1", fullname: "Bruce Wayne", bio: "Gotham's dark knight", email: "nightwatcher@gotham.com"),
            User(id: NSUUID().uuidString, username: "clarkKent", profileImageURL: "batman-1", fullname: "Clark Kent", bio: "Krypton's last son", email: "clark.kent@dailyplanet.com"),
            User(id: NSUUID().uuidString, username: "dianaPrince", profileImageURL: "batman-2", fullname: "Diana Prince", bio: "Amazonian warrior princess", email: "diana.prince@themyscira.com"),
            User(id: NSUUID().uuidString, username: "barryAllen", profileImageURL: "image-url-4", fullname: "Barry Allen", bio: "Test bio", email: "barry.allen@starlabs.com")
        ]
    }
}
