//
//  HomeViewController.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 10/06/22.
//

import SwiftUI

struct HomeViewController: View {
    var body: some View {
        NavigationView {
            Text("HomeViewController")
                .navigationBarTitle("HomeViewController")
        }
    }
}

struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewController()
    }
}
