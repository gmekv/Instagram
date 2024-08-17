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
        print("ProfileViewModel initialized with user: \(user)")
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
            print("Attempting to follow user ID: \(user.id)")
            try await UserService.follow(uid: user.id)
            user.isFollowed = true
            print("User followed: \(user.id), isFollowed: \(String(describing: user.isFollowed))")
            self.user.stats = try await UserService.fetchUserStats(uid: user.id)
        }
    }
    
    func unfollow() {
        Task {
            print("Attempting to unfollow user ID: \(user.id)")
            try await UserService.unfollow(uid: user.id)
            user.isFollowed = false
            self.user.stats = try await UserService.fetchUserStats(uid: user.id)
        }
    }
    
    func checkIfUserIsFollowed() {
        Task {
            print("Checking if user is followed for user ID: \(user.id)")
            self.user.isFollowed = try await UserService.checkIFuserisFollowed(uid: user.id)
            print("Checked follow status: isFollowed: \(String(describing: self.user.isFollowed))")
        }
    }
}
