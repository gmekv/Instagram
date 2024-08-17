//
//  NotificationCell.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 17.08.24.
//

import SwiftUI

struct NotificationCell: View {
    let notification: Notification
    
    var body: some View {
        HStack {
            CircularProfileImageView(user: nil, size: .xSmall)
            
            HStack(spacing: 4) {
                Text("Yuki")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text("\(notification.type.notificationMessage)")
                    .font(.subheadline)
                
                Text("3w")
                    .foregroundStyle(.gray)
                    .font(.footnote)
            }
            
            Spacer()
            if notification.type != .follow {
                
                Image("black-panther-1")
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
