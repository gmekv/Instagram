//
//  RegistrationViewModel.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 03.06.24.
//

import Foundation

@MainActor

class RegistrationViewModel: ObservableObject {
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    func createUSer() async throws {
     try await   AuthService.shared.createUser(email: email, password: password, username: username)
        username = ""
        email = ""
        password = ""
    }
}
