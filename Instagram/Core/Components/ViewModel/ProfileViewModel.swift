//
//  ProfileViewModel.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 28.07.24.
//

import SwiftUI
@MainActor

class ProfileViewModel: ObservableObject {
    @Published var user: User
    init(user: User) {
        self.user = user
        checkIfUserIsFollowed()
        fetchUserStats()
    }
    func fetchUserStats() {
        Task {
            self.user.stats = try await UserService.fetchUserStats(uid: user.id)
        }
    }
}

extension ProfileViewModel {
    func follow() {
        Task {
            try await UserService.follow(uid: user.id)
            user.isFollowed = true
        }
    }
    
    func unfollow() {
        Task {
            try await UserService.unfollow(uid: user.id)
            user.isFollowed = false
        }}
    
    func checkIfUserIsFollowed() {
        Task {
            self.user.isFollowed = try await UserService.checkIFuserisFollowed(uid: user.id)
        }
    }
}
