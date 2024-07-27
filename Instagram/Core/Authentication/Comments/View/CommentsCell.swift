//
//  CommentsCell.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 07.07.24.
//

import SwiftUI

struct CommentsCell: View {
    
    let comment: Comment
    private var user: User? {
        return comment.user
    }
    var body: some View {
        HStack {
            CircularProfileImageView(user: user, size: .xSmall)
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 2) {
                    Text(user?.username ?? "")
                        .fontWeight(.semibold)
                    Text(comment.timestamp.timestampString())
                        .foregroundStyle(.gray)
                }
                Text(comment.commentText)
            }
                .font(.caption)
                Spacer()
            }
            .padding(.horizontal )
        }
    }


struct CommentsCell_Previews: PreviewProvider {
    static var previews: some View {
        CommentsCell(comment: dev.comment)
    }
}
