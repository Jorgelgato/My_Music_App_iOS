//
//  HomeViewController.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 10/06/22.
//

import SwiftUI

struct HomeViewController: View {
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView {
            Text("HomeViewController")
                .navigationBarTitle("HomeViewController")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button {
                        showingSheet.toggle()
                    } label: {
                        Image(systemName: "gearshape")
                    }
                    .sheet(isPresented: $showingSheet) {
                        SettingsViewController(showingSheet: $showingSheet)
                    }
                }
        }
    }
}

struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewController()
    }
}
