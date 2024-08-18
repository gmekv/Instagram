//
//  NotificationView.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 17.08.24.
//

import SwiftUI

struct NotificationView: View {
    @StateObject var viewModel = NotificationsViewModel(service: NotificaitonService())
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(viewModel.notifications) { notification in NotificationCell(notification: notification)
                            .padding(.top)
                    }
                }
            }
        }
    }
}
