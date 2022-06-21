//
//  ContentView.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 10/06/22.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            HomeViewController()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            SearchViewController()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            LibraryViewController()
                .tabItem {
                    Label("Library", systemImage: "music.note.list")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
