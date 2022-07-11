//
//  WelcomeViewController.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 10/06/22.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color("Background").edgesIgnoringSafeArea(.all)
                AuthViewController()
                    .navigationBarHidden(true)
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct WelcomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
