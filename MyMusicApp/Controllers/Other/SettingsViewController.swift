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
            VStack(spacing: 20) {
                NavigationLink {
                    ProfileViewController()
                } label: {
                    Text("Profile")
                }
                
                Button {
                    showingSheet.toggle()
                    AuthManager.shared.isSignedIn = false
                } label: {
                    Text("Logout")
                }
            }
            .navigationBarTitle("Settings")
        }
    }
}

struct SettingsViewController_Previews: PreviewProvider {
    static var previews: some View {
        SettingsViewController(showingSheet: .constant(true))
    }
}
