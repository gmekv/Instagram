//
//  CompleteSignaupView.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 27.05.24.
//

import SwiftUI

struct CompleteSignupView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            Text("Create username")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            Text("You'll use this email to sign in to your account")
                .font(.footnote)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
      
            
            NavigationLink {
                CreatePasswordView()
                    .navigationBarBackButtonHidden()
            } label: {
                Text("Next")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 360, height: 44)
                    .background(Color(.systemBlue))
                    .cornerRadius(8)
            }
            .padding(.vertical)
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss()
                    }
            }
        }}
}

#Preview {
    CompleteSignupView()
}
