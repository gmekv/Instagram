//
//  Comment.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 07.07.24.
//

import Firebase
import FirebaseFirestoreSwift

struct Comment: Identifiable, Codable {
    @DocumentID var commentID: String?
    let postIwnerUiD: String
    let commentText: String
    let postID: String
    let timestamp: Timestamp
    let commentOnwerUid: String
    
    var user: User?
    
    var id: String {
        return commentID ?? NSUUID().uuidString
    }
    }
