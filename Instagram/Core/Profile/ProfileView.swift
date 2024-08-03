//
//  ProfileView.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 22.05.24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel: PostGridViewModel
    let user: User
    
    init(user: User) {
        self.user = user
        _viewModel = StateObject(wrappedValue: PostGridViewModel(user: user))
    }
    
    var body: some View {
        ScrollView {
            // header
            ProfileHeaderView(user: user)
            // post grid view
            PostGridView(posts: viewModel.posts)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Profile")
        .refreshable {
            Task {
                print("Refresh triggered")
                try await viewModel.fetchUserPosts()
            }
        }
        .environmentObject(viewModel)
        .onAppear {
            print("ProfileView onAppear")
            print("DEBUG: Initial post count: \(viewModel.posts.count)")
            Task {
                print("Starting fetchUserPosts task from onAppear")
                try await viewModel.fetchUserPosts()
                print("DEBUG: Post count after fetch: \(viewModel.posts.count)")
            }
        }
    }}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User.mock_Users[1])
    }
}
