//
//  HomeViewController.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 10/06/22.
//

import SwiftUI

struct HomeViewController: View {
    @State private var settingsSheet = false
    @State private var albumSheet = false
    @StateObject private var homeViewVM: HomeViewVM = HomeViewVM()
    @State private var selectedAlbum: AlbumModel? = nil
    private var threeColumnGrid = [GridItem(.fixed(130)), GridItem(.fixed(130)), GridItem(.fixed(130))]
    private var twoColumnGrid = [GridItem(.fixed(270)), GridItem(.fixed(270))]
    
    var body: some View {
        NavigationView {
            ScrollView {
                //MARK: New releases
                if (homeViewVM.albums.isEmpty) {
                    ProgressView()
                } else {
                    Text("New Releases")
                        .font(.title.bold())
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: threeColumnGrid) {
                            ForEach (homeViewVM.albums, id: \.self) { album in
                                NavigationLink(destination: AlbumViewController(id: album.id)) {
                                    Release(album)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                }
                
                
                //MARK: Playlists
                if (homeViewVM.playlists.isEmpty) {
                    ProgressView()
                } else {
                    Text("Featured Playlists")
                        .font(.title.bold())
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: twoColumnGrid) {
                            ForEach (homeViewVM.playlists, id: \.self) { playlist in
                                NavigationLink(destination: PlaylistViewController(id: playlist.id)) {
                                    Playlist(playlist)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                }
                
                //MARK: Recomendations
                if (homeViewVM.recomendations.isEmpty) {
                    ProgressView()
                } else {
                    Text("Recomendations")
                        .font(.title.bold())
                    LazyVStack {
                        ForEach (homeViewVM.recomendations, id: \.self) { track in
                            Track(track)
                        }
                    }
                    .padding(.horizontal, 10)
                }
                
            }
            .navigationBarTitle("Browse")
            .toolbar {
                Button {
                    settingsSheet.toggle()
                } label: {
                    Image(systemName: "gearshape")
                }
                .sheet(isPresented: $settingsSheet) {
                    SettingsViewController(showingSheet: $settingsSheet)
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
