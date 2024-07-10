//
//  CommentsCell.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 07.07.24.
//

import SwiftUI

struct CommentsCell: View {
    private var user: User {
        return User.mock_Users[1]
    }
    var body: some View {
        HStack {
            CircularProfileImageView(user: User.mock_Users[0], size: .xSmall)
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 2) {
                    Text(user.username)
                        .fontWeight(.semibold)
                    Text("6D")
                        .foregroundStyle(.gray)
                }
                Text("How is my car looking")
            }
                .font(.caption)
                Spacer()
            }
            .padding(.horizontal )
        }
    }


#Preview {
    CommentsCell()
}
