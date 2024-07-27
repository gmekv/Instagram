//
//  EditProfileViewModel.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 10.06.24.
//

import Firebase
import PhotosUI
import SwiftUI

@MainActor

class EditProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var selectedImage: PhotosPickerItem? {
        didSet {
            Task {
                await loadImage(fromItem: selectedImage)
            }
        }
    }

    @Published var profileImage: Image?
    @Published var fullName = ""
    @Published var bio = ""

    private var uiImage: UIImage?

    init(user: User) {
        self.user = user
        if let fullname = user.fullname {
            self.fullName = fullname
        }
        if let bio = user.bio {
            self.bio = bio
        }
        if let profileImageURL = user.profileImageURL {
            print("Current profile image URL: \(profileImageURL)")
        }
    }

    @MainActor
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }

        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        profileImage = Image(uiImage: uiImage)
    }

    func updateUserData() async throws {
        var data = [String: Any]()
        
        if let uiImage = uiImage {
             let imageUrl = try await ImageUploader.uploadImage(image: uiImage)
             data["profileImageURL"] = imageUrl
             print("New profile image URL: \(imageUrl)")
         }

        // update name if changed
        if !fullName.isEmpty && user.fullname != fullName {
            user.fullname = fullName
            data["fullname"] = fullName
        }

        // update bio if changed
        if !bio.isEmpty && user.bio != bio {
            user.bio = bio
            data["bio"] = bio
        }
        if !data.isEmpty {
            try await FirebaseConstants.UserCollection.document(user.id).updateData(data)
            try await AuthService.shared.loadUserData()
        }
    }
}
