//
//  ProfileViewController.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 10/06/22.
//

import SwiftUI

struct ProfileViewController: View {
    @State private var user: User? = nil
    @State private var error: Bool = false
    
    var body: some View {
        ZStack {
            if user == nil {
                if error {
                    Text("Algo salió mal :(")
                } else {
                    ProgressView()
                        .scaleEffect(3)
                }
            } else {
                VStack(spacing: 20) {
                    ProfileImage(self.user!.images[0].url)
                    
                    Text(self.user!.display_name)
                        .font(.title.bold())
                    
                    Text(self.user!.product)
                        .font(.title2)
                }
            }
        }
        .onAppear {
            loadUserData()
        }
    }
    
    func loadUserData (){
        APICaller.shared.getCurrentUserProfile { result in
            switch result {
            case .success(let model):
                self.user = model
                break
            case .failure(let error):
                self.error = true
                print(error.localizedDescription)
            }
        }
    }
}

struct ProfileViewController_Previews: PreviewProvider {
    static var previews: some View {
        ProfileViewController()
    }
}
