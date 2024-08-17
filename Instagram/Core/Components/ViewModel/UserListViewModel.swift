//
//  SearchViewModel.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 10.08.24.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    init() {
        Task { try await fetchAllUsers()}
    }
    
    @MainActor
    func fetchAllUsers() async throws {
        self.users = try await UserService.fetchAllUsers()
    }
}
