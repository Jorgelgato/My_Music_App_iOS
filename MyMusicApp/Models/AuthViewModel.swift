//
//  AuthViewModel.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 16/06/22.
//

import Foundation
import Combine

class AuthViewModel: ObservableObject {
    @Published
    var currentUser: String?

    var userIsLoggedIn: Bool {
      currentUser != nil
    }

    func logOut() {
      currentUser = nil
    }

    func logIn() {
      currentUser = "Demo"
    }
}
