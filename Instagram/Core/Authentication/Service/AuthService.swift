//
//  AuthService.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 03.06.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore

class AuthService {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?

    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        Task { try await loadUserData()}
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await loadUserData()
        } catch {
            print("Debug, failed to register user with error \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(email: String, password: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            await self.uploadUserData(uid: result.user.uid, username: username, email: email)
        } catch {
            print("Debug: Failed to register user with error \(error.localizedDescription)")
            print(password)
        }
    }
    
    @MainActor
    func loadUserData() async throws {
        self.userSession = Auth.auth().currentUser
        guard let currentIod = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("users").document(currentIod).getDocument()
        self.currentUser = try snapshot.data(as: User.self)

    }
    func signOut() {
        try? Auth.auth().signOut()
        userSession = nil
        self.currentUser = nil
    }
    
    private func uploadUserData(uid: String, username: String, email: String) async {
        let user = User(id: uid, username: username, email: email)
        self.currentUser = user
       guard let encodedUser =  try? Firestore.Encoder().encode(user) else  {return}
        try? await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
    }
}
