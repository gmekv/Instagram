//
//  SearchView.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 26.05.24.
//

import SwiftUI


struct SearchView: View {
    @State private var searchText = ""
    @StateObject var viewModel = SearchViewModel()

    var body: some View {
        NavigationStack {
            UserListView(config: .explore)
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: User.self) { user in
                ProfileView(user: user)
            }
            .navigationTitle("Explore")
            .onAppear {
                Task {
                    try await viewModel.fetchAllUsers()
                }
            }
            .refreshable {
                Task {
                    try await viewModel.fetchAllUsers()
                }
            }
        }
    }

    func profileImage(user: User) -> Image {
        if let profileImageURL = user.profileImageURL {
            return Image(profileImageURL)
        } else {
            return Image(systemName: "person.circle")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
