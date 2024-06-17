//
//  ProfileHeadeView.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 01.06.24.
//

import SwiftUI

struct ProfileHeaderView: View {
    let user: User
    var body: some View {
        VStack(spacing: 10) {
            //pic and stats
            HStack {
                Image(user.profileImageURL ?? "")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                Spacer()
                HStack(spacing: 8){
                    
                    UserStatView(value: 3, title: "Posts")
                    UserStatView(value: 3, title: "Followers")
                    UserStatView(value: 3, title: "Following")
                }
            } .padding(.horizontal)
            //name and bio
            VStack(alignment: .leading, spacing: 4) {
                if let fullname = user.fullname {
                    Text(fullname)
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                if let bio = user.bio {
                    Text(bio)
                        .font(.footnote)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            Button {
                
            } label: {
                Text("Edit Profile")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height: 32)
                    .foregroundStyle(.black)
                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/))
            }
            
            
            Divider()
        }    }
}

#Preview {
    ProfileHeaderView(user: User.Mock_Users[0])
}
