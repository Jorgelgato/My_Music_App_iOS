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
                Color.green.edgesIgnoringSafeArea(.all)
                AuthViewController()
                    .navigationBarTitle("My Music App")
            }
        }
    }
}

struct WelcomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
