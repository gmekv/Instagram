//
//  ContentViewModel.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 03.06.24.
//

import Combine
import Firebase
import FirebaseAuth
import Foundation

@MainActor
class ContentViewModel: ObservableObject {
    private let service = AuthService.shared
    private var cancellables = Set<AnyCancellable>()

    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?

    init() {
        setupSubscribers()
    }

    @MainActor
    func setupSubscribers() {
        service.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }
        .store(in: &cancellables)

        UserService.shared.$currentUser.sink { [weak self] currentUser in
            self?.currentUser = currentUser
        }
        .store(in: &cancellables)
    }
}
