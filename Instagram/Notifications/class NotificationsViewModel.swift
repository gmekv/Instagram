//
//  class NotificationsViewModel.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 17.08.24.
//

import Foundation


class NotificationsViewModeImage: ObservableObject {
    @Published var notifcations = [Notification]()
    init() {
       fetchNotificaitons()
    }
    
    func fetchNotificaitons() {
        self.notifcations = DeveloperPreview.shared.notifications
    }
}
