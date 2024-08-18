//
//  NotificationCell.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 17.08.24.
//

import SwiftUI
import Kingfisher

struct NotificationCell: View {
    let notification: Notification
    
    var body: some View {
        HStack {
            CircularProfileImageView(user: notification.user, size: .xSmall)
            HStack(spacing: 4) {
                Text(notification.user?.username ?? "")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text("\(notification.type.notificationMessage)")
                    .font(.subheadline)
                
                Text(" \(notification.timestamp.timestampString())")
                    .foregroundStyle(.gray)
                    .font(.footnote)
            }
            
            Spacer()
            if notification.type != .follow {
                KFImage(URL(string: notification.post?.imageUrl ?? ""))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipped()
                    .padding(.leading, 2)
            }
            else {
                Button(action: {}, label: {
                    Text("Follow")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                })
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    NotificationCell(notification: DeveloperPreview.shared.notifications[0])
}
