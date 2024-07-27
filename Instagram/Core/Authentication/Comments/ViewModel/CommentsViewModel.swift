//
//  CommentsViewModel.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 07.07.24.
//

import Firebase
 
@MainActor

class CommentsViewModel: ObservableObject {
    @Published var comments = [Comment]()
    private let post: Post
    private let service: CommentService
    
    init(post: Post) {
        self.post = post
        self.service = CommentService(postId: post.id)
        Task { try await fetchComments() }
    }
    
    func uploadComment(commentText: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let comment = Comment(postIwnerUiD: post.ownerUid, commentText: commentText, postID: post.id, timestamp: Timestamp(), commentOnwerUid: uid)
        self.comments.append(comment)
        try await service.uploadComment(comment)
        print("comment upload : \(comment)")
    }
    

    
    func fetchComments() async throws {
        self.comments = try await service.fetchComments()
        try await fetchUserDataForComments()
    }
    
    private func fetchUserDataForComments() async throws {
        for i in 0 ..< comments.count {
            let comment = comments[i]
            let user = try await UserService.fetchUser(withUid: comment.commentOnwerUid)
            comments[i].user = user
        }
    }
}
