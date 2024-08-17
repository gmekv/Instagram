//
//  ProfileViewModel.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 28.07.24.
//
import SwiftUI
import Firebase

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func fetchUserStats() {
        Task {
            guard user.stats == nil else {
                return }
            Task {
                self.user.stats = try await UserService.fetchUserStats(uid: user.id)
            }}
    }
}

extension ProfileViewModel {
    func follow() {
        Task {
            try await UserService.follow(uid: user.id)
            user.isFollowed = true
            self.user.stats = try await UserService.fetchUserStats(uid: user.id)
            NotificationManager.shared.uploadFollowNotification(toUid: user.id)
        }
    }
    
    func unfollow() {
        Task {
            try await UserService.unfollow(uid: user.id)
            user.isFollowed = false
            self.user.stats = try await UserService.fetchUserStats(uid: user.id)
        }
    }
    
    func checkIfUserIsFollowed() {
        Task {
            self.user.isFollowed = try await UserService.checkIFuserisFollowed(uid: user.id)
        }
    }
}
