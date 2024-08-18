//
//  Constants.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 27.07.24.
//

import Firebase

public struct FirebaseConstants {
    static let Root = Firestore.firestore()
    static let UserCollection = Root.collection("users")
    static let PostsCollection = Root.collection("posts")
    static let FollowingCOlelction = Root.collection("following")
    static let FollowersCollection = Root.collection("followers")
    static let NotifcationCollection = Root.collection("notification")
    static func UserNotificationCollection(uid: String) -> CollectionReference {
        return NotifcationCollection.document(uid).collection("user-notification")
    }
 }
