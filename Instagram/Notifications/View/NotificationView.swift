//
//  NotificationView.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 17.08.24.
//

import SwiftUI

struct NotificationView: View {
    @StateObject var viewModel = NotificationsViewModeImage()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(viewModel.notifcations) { notification in NotificationCell(notification: notification)
                            .padding(.top)
                    }
                }
            }
        }
    }
}
