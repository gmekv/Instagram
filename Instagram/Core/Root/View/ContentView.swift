//
//  ContentView.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 22.05.24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var ViewModel = ContentViewModel()
    @StateObject var registrationViewmodel = RegistrationViewModel()

    var body: some View {
        Group {
            if ViewModel.userSession == nil {
                LoginView()
                    .environmentObject(registrationViewmodel)
            } else if let currentUser = ViewModel.currentUser {
                MainTabView(user: currentUser)
                    .environmentObject(ViewModel)

            }
        }
    }}
#Preview {
    ContentView()
}
