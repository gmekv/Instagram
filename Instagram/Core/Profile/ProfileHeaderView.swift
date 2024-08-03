//
//  ProfileHeadeView.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 01.06.24.
//

import Kingfisher
import SwiftUI

struct ProfileHeaderView: View {
    @State private var showEditProfile = false
    @EnvironmentObject var PostviewModel: PostGridViewModel
    @ObservedObject var viewModel: ProfileViewModel
    private var user: User {
        return viewModel.user
    }
    
    private var isFollowed: Bool {
        return user.isFollowed ?? false
    }
    
    private var buttonTitle: String {
        if user.isCurrentUser {
            return "Edit Profile"
        } else {
            return isFollowed ? "Following" : "Follow"
        }
    }
    private var buttonBackgroundColor: Color {
        if user.isCurrentUser || isFollowed {
            return .white
        } else {
            
            return Color(.systemBlue)
        }}

    private var buttonForegroundColor: Color {
        if user.isCurrentUser || isFollowed {
            return .black
        } else {
            return .white
        }
    }
    
    private var buttonBorderColor: Color {
        if user.isCurrentUser || isFollowed {
            return .gray
        } else {
            return .clear
        }
    }
    
    init(user: User) {
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        VStack(spacing: 10) {
            // pic and status
            HStack {
                CircularProfileImageView(user: PostviewModel.user, size: .large)
                Spacer()
                UserStatView(value: PostviewModel.postsCount, title: "Posts")
                UserStatView(value: 1, title: "Followers")
                UserStatView(value: 2, title: "Following")
            }
            .padding(.horizontal)
            //                .padding(.bottom, 4)

            // Name and Bio
            VStack(alignment: .leading, spacing: 4) {
                if let fullname = PostviewModel.user.fullname {
                    Text(fullname)
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                if let bio = PostviewModel.user.bio {
                    Text(bio)
                        .font(.footnote)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)

            // Action Button
            Button {
                if PostviewModel.user.isCurrentUser {
                    showEditProfile.toggle()
                } else {
                    handleFollowTapped()
                }
            } label: {
                Text(buttonTitle)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height: 34)
                    .background(buttonBackgroundColor)
                    .foregroundColor(buttonForegroundColor)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .strokeBorder(buttonBorderColor, lineWidth: 1)
                    )
            }

            Divider()
        }
        .fullScreenCover(isPresented: $showEditProfile) {
            EditProfileView(user: PostviewModel.user)
        }
    }
    func handleFollowTapped() {
        if isFollowed   {
            viewModel.unfollow()
        } else {
            viewModel.follow()
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(user: User.mock_Users[0])
    }
}
