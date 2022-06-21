//
//  MyMusicAppApp.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 10/06/22.
//

import SwiftUI

@main
struct MyMusicApp: App {
    @AppStorage("signed") private var isSignedIn: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if isSignedIn {
                TabBarView()
            } else {
                WelcomeView()
            }
        }
    }
}
