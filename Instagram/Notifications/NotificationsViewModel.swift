//
//  class NotificationsViewModel.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 17.08.24.
//

import Foundation

@MainActor

class NotificationsViewModel: ObservableObject {
    @Published var notifications = [Notification]()
    private let service: NotificaitonService
    
    init(service: NotificaitonService) {
        self.service = service
        Task { await  fetchNotificaitons() }
    }
    
    func fetchNotificaitons() async {
        do {
            print("Starting to fetch notifications")
            self.notifications = try await service.fetchNotifications()
            print("Fetched \(self.notifications.count) notifications")
            try await updateNotifications()
            print("Updated notifications")
        } catch {
            print("Debug: failed to fetch notifications \(error.localizedDescription)")
        }
    }
    
    private func updateNotifications() async throws {
        for i in 0 ..< notifications.count {
            var notification = notifications[i]
            notification.user = try await UserService.fetchUser(withUid: notification.notificationSenderUid)
            
            if let postId = notification.postID {
                notification.post = try await PostService.fetchPost(postId)
            }
            notifications[i] = notification
        }
    }
}
