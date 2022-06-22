//
//  SettingsViewController.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 10/06/22.
//

import SwiftUI

struct SettingsViewController: View {
    @Binding var showingSheet: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink {
                    ProfileViewController()
                } label: {
                    Text("Profile")
                }
                
                Button {
                    AuthManager.shared.isSignedIn = false
                    self.showingSheet = false
                } label: {
                    Text("Logout")
                }
            }
            .navigationBarTitle("SettingsViewController")
        }
    }
}

struct SettingsViewController_Previews: PreviewProvider {
    static var previews: some View {
        SettingsViewController(showingSheet: .constant(true))
    }
}
