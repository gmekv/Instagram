//
//  SearchViewModel.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 08.06.24.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var users = [User]()

    @MainActor
    func fetchAllUsers() async throws {
        self.users = try await UserService.fetchAllUsers()
    }
}
