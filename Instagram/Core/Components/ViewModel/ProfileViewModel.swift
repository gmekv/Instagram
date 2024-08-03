//
//  ProfileViewModel.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 28.07.24.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var user: User
    init(user: User) {
        self.user = user
    }
}

extension ProfileViewModel {
    func follow() {
        user.isFollowed = true
    }
    
    func unfollow() {
        user.isFollowed = false 
    }
    func checkIfUserIsFollowed() {
        
    }
}
