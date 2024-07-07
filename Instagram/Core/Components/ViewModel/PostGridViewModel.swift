//
//  PostGridViewModel.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 10.06.24.
//

import Foundation

class PostGridViewModel: ObservableObject {
    @Published var user: User
    @Published var posts = [Post]()
    var isDataFetched = false

    var postsCount: Int {
        posts.count
    }

    init(user: User) {
        self.user = user
    }

    @MainActor
    func fetchUserPosts() async throws {
            posts = try await PostService.fetchUserPosts(uid: user.id)
    }
    
    @MainActor
      func updateUser() async throws {
          self.user = try await UserService.fetchUser(withUid: user.id)
      }
}
