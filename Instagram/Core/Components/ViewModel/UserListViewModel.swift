//
//  SearchViewModel.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 10.08.24.
//

import Foundation

@MainActor

class UserListViewModel: ObservableObject {
    @Published var users = [User]()
    init() {
    }
    
    func fetchUsers(forConfig config: UserListConfig) async  {
        do {
            self.users = try await UserService.fetchUsers(forConfig: config)
        } catch {
        }
    }}
