//
//  SearchView.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 26.05.24.
//

import SwiftUI

struct SearchView: View {
    @State private var saerchText = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(User.Mock_Users){ user in
                        NavigationLink(value: user) {
                            HStack {
                                Image(user.profileImageURL ?? "")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                
                                VStack(alignment: .leading) {
                                    Text(user.username)
                                        .fontWeight(.semibold)
                                    if let fullname = user.fullname {
                                        Text(fullname)
                                    }
                                }
                                .font(.footnote)
                                Spacer()
                            }
                            .foregroundStyle(.black)
                            .padding(.horizontal)
                        }}
                    }
                .padding(.top, 8)
                .searchable(text: $saerchText, prompt: "Search...")
            }
        .navigationDestination(for: User.self, destination: { user in
            ProfileView(user: user)
        })
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
        }}
}

#Preview {
    SearchView()
}
