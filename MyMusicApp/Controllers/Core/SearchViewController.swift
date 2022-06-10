//
//  SearchViewController.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 10/06/22.
//

import SwiftUI

struct SearchViewController: View {
    var body: some View {
        NavigationView {
            Text("SearchViewController")
                .navigationBarTitle("SearchViewController")
        }
    }
}

struct SearchViewController_Previews: PreviewProvider {
    static var previews: some View {
        SearchViewController()
    }
}
