//
//  LoginView.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 26.05.24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack{
                Spacer()
                
                Image("instagram-black")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 100)
                VStack {
                    TextField("Enter your email", text: $viewModel.email)
                        .textInputAutocapitalization(.none)
                        .modifier(IGTextFieldModifier())
                    SecureField("Enter your password", text: $viewModel.password)
                        .textInputAutocapitalization(.none)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                }
                Button(action: {
                    print("Show forgot password")
                }) {
                    Text("Forgot password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                .padding(.top)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 28)
                
                .frame(maxWidth: .infinity, alignment: .trailing)
                Button(action: {
                    // Initiate the Task for handling asynchronous work
                    Task {
                        do {
                            try await viewModel.signIn()
                        } catch {
                            print("Error during sign in: \(error.localizedDescription)")
                        }
                    }
                }) {                 Text("Login")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 44)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding(.vertical)
                HStack {
                    Rectangle()
                        .frame(width:  (UIScreen.main.bounds.width / 3) - 40, height: 0.5)
                    Text("OR")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    Rectangle()
                        .frame(width:  (UIScreen.main.bounds.width / 3) - 40, height: 0.5)
                    
                }
                .foregroundStyle(.gray)
                HStack {
                    Image("facebook-logo")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Continue with Facebook")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(.systemBlue))
                }
                .padding(.top, 8)
                Spacer()
                Divider()
                NavigationLink {
                    AddEmailView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.semibold)
                    }
                }
                
            }}
        }    }


#Preview {
    LoginView()
}
