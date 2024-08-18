//
//  class NotificationsViewModel.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 17.08.24.
//

import Foundation

@MainActor

class NotificationsViewModeImage: ObservableObject {
    @Published var notifcations = [Notification]()
    private let service: NotificaitonService
    
    init(service: NotificaitonService) {
        self.service = service
        Task { await  fetchNotificaitons() }
    }
    
    func fetchNotificaitons() async {
        do {
            self.notifcations = DeveloperPreview.shared.notifications
        } catch {
            print("debug: failed to fetch notifications \(error.localizedDescription)")
        }
    }
}
