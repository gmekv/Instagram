//
//  CreatePasswordView.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 27.05.24.
//

import SwiftUI

struct CreatePasswordView: View {
    @EnvironmentObject var viewModel: RegistrationViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 12) {
            Text("Create a password")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            Text("Your password must be at least 6 characters in length")
                .font(.footnote)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            SecureField("Password", text: $viewModel.password)
                .textInputAutocapitalization(.none)
                .modifier(IGTextFieldModifier())
                .padding(.top)
            
            NavigationLink(destination: {
                CompleteSignUpView()
            }, label: {
                Text("Login")
                               .font(.subheadline)
                               .fontWeight(.semibold)
                               .foregroundStyle(.white)
                               .frame(width: 360, height: 44)
                               .background(Color(.systemBlue))
                               .clipShape(RoundedRectangle(cornerRadius: 8))
            })

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
    CreatePasswordView()
}
