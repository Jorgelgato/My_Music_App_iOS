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
                    SettingsItem(title: "Profile")
                }
                
                Button {
                    showingSheet.toggle()
                    AuthManager.shared.isSignedIn = false
                } label: {
                    SettingsItem(title: "Log out")
                }
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Settings")
        }
        .navigationViewStyle(.stack)
    }
}

struct SettingsItem: View {
    let title: String
    let text: String
    let size: Size
    
    init(title: String, text: String = "", _ size: Size = .small) {
        self.title = title
        self.text = text
        self.size = size
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .lineLimit(1)
                    .font(.title3.bold())
                Text(text)
                    .lineLimit(1)
                    .font(.title3)
            }
            .padding(4)
            Spacer()
        }
        .padding()
        .frame(height: size.rawValue)
        .background(Color("Background"))
    }
}


struct SettingsViewController_Previews: PreviewProvider {
    static var previews: some View {
        SettingsViewController(showingSheet: .constant(true))
    }
}
