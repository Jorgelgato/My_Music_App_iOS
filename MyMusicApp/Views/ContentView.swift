//
//  ContentView.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 10/06/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        if AuthManager.shared.isSignedIn {
            TabBarViewController()
        } else {
            WelcomeViewController()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
