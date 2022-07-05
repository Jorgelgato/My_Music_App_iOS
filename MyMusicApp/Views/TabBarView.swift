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
            ZStack {
                HomeViewController()
                PlayerBar()
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            
            ZStack {
                SearchViewController()
                PlayerBar()
            }
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
            
            ZStack {
                LibraryViewController()
                PlayerBar()
            }
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
