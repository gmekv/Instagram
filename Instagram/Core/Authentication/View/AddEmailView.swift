//
//  AddEmailView.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 27.05.24.
//

import SwiftUI

struct AddEmailView: View {
    @State private var email = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RegistrationViewModel

    var body: some View {
        VStack(spacing: 12) {
            Text("Add your email")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            Text("You'll use this email to sign in to your account")
                .font(.footnote)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            TextField("Email", text: $viewModel.email)
                .textInputAutocapitalization(.none)
                .modifier(IGTextFieldModifier())
            
            NavigationLink(destination: {
                CreateUserNameView()
                    .navigationBarBackButtonHidden()
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
        }
    }
}

#Preview {
    AddEmailView()
}
