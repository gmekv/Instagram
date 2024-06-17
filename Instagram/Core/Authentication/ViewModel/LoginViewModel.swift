//
//  LoginViewModel.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 07.06.24.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws {
        try? await AuthService.shared.login(withEmail: email, password: password)
    }
}

