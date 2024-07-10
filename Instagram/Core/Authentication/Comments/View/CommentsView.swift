//
//  CommentsView.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 07.07.24.
//

import SwiftUI

struct CommentsView: View {
    @State private var commentText = ""
    var body: some View {
        VStack {
            Text("Comments")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.top, 24)
            Divider()
            ScrollView {
                LazyVStack(spacing: 24) {
                             ForEach(1...15, id: \.self) { comment in
                                 CommentsCell()
                             }
                         }
            }
            .padding(.top)
            Divider()
            HStack(spacing: 12) {
                CircularProfileImageView(user: User.mock_Users[0], size: .xSmall)
                ZStack(alignment: .trailing) {
                    TextField("Add a coment", text: $commentText, axis: .vertical)
                        .font(.footnote)
                        .padding(12)
                        .padding(.trailing, 40)
                        .overlay {
                            Capsule()
                                .stroke(Color(.systemGray5), lineWidth: 1)
                        }
                    Button(action: {}, label: {
                        Text("Post")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color(.systemBlue))
                    })
                    .padding(.horizontal)
                }
            }
            .padding(12)
        }
    }
}

#Preview {
    CommentsView()
}
