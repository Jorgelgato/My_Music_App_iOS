//
//  ProfileViewController.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 10/06/22.
//

import SwiftUI

struct ProfileViewController: View {
    @StateObject private var userViewModel: UserViewModel = UserViewModel()
    
    var body: some View {
        ZStack {
            if userViewModel.user == nil {
                if userViewModel.error {
                    Text("Algo salió mal :(")
                } else {
                    ProgressView()
                        .scaleEffect(3)
                }
            } else {
                VStack(spacing: 20) {
                    ProfileImage(userViewModel.user!.images?.count ?? 0 > 0 ? userViewModel.user!.images![0].url : "error")
                    
                    Text(userViewModel.user!.display_name!)
                        .font(.title.bold())
                    
                    Text(userViewModel.user!.product!)
                        .font(.title2)
                }
            }
        }
        .navigationBarTitle("Profile")
        .onAppear {
            userViewModel.loadUserData()
        }
    }
    
}

struct ProfileViewController_Previews: PreviewProvider {
    static var previews: some View {
        ProfileViewController()
    }
}
