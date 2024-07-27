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

}
