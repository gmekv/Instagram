//
//  CommentService.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 07.07.24.
//

import FirebaseFirestoreSwift
import Firebase

struct CommentService   {
    static func uploadComment(_ comment: Comment, postID: String  ) async throws {
        guard let commentData = try? Firestore.Encoder().encode(comment) else {return}
        try await Firestore.firestore().collection("path").document(postID).collection("post-comments").addDocument(data: commentData)
    }
}
