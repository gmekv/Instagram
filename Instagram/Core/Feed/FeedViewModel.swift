//
//  FeedViewModel.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 16.06.24.
//

import Firebase
import Foundation

class FeedViewModel: ObservableObject {
    @Published var Feedposts = [Post]()

    @MainActor
    func fetchPosts() async throws {
        Feedposts = try await PostService.fetchFeedPosts()
    }

    @MainActor
    func toggleLike(postId: String, uid: String) async throws {
        try await PostService.toggleLike(postId: postId, uid: uid)
        let likedPostIndex = Feedposts.firstIndex { post in
            post.id == postId
        }

        if let index = likedPostIndex {
            if Feedposts[index].liked!.contains(uid) {
                Feedposts[index].likes -= 1
                Feedposts[index].liked!.removeAll(where: { $0 == uid })
            } else {
                Feedposts[index].likes += 1
                Feedposts[index].liked!.append(uid)
            }
        }
    }
}
