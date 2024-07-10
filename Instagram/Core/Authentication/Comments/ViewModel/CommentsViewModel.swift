//
//  CommentsViewModel.swift
//  Instagram
//
//  Created by Giorgi Mekvabishvili on 07.07.24.
//

import Foundation

class CommentsViewModel: ObservableObject {
    @Published var comments = [Comment]()
    
}
