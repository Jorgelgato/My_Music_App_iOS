//
//  HomeViewController.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 10/06/22.
//

import SwiftUI

struct HomeViewController: View {
    @State private var settingsSheet = false
    @StateObject private var homeViewVM: HomeViewVM = HomeViewVM()
    @AppStorage("device_id") private var isDeviceID: String?
    
    var body: some View {
        if isDeviceID == nil {
            ProgressView()
        } else {
            NavigationView {
                ScrollView {
                    //MARK: New releases
                    Text("New Releases")
                        .font(.title.bold())
                    if (homeViewVM.albums.isEmpty) {
                        ProgressView()
                    } else {
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: [GridItem(.fixed(130)), GridItem(.fixed(130)), GridItem(.fixed(130))]) {
                                ForEach (homeViewVM.albums, id: \.self) { album in
                                    NavigationLink(destination: AlbumViewController(id: album.id)) {
                                        ReleaseItem(album)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                    
                    
                    //MARK: Playlists
                    Text("Featured Playlists")
                        .font(.title.bold())
                    if (homeViewVM.playlists.isEmpty) {
                        ProgressView()
                    } else {
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: [GridItem(.fixed(280)), GridItem(.fixed(280))]) {
                                ForEach (homeViewVM.playlists, id: \.self) { playlist in
                                    NavigationLink(destination: PlaylistViewController(id: playlist.id)) {
                                        PlaylistItem(playlist)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                    
                    //MARK: Recomendations
                    Text("Recomendations")
                        .font(.title.bold())
                    if (homeViewVM.recomendations.isEmpty) {
                        ProgressView()
                    } else {
                        LazyVStack {
                            ForEach (homeViewVM.recomendations, id: \.self) { track in
                                Button {
                                    PlayerViewModel.shared.startPlayback(trackUri: track.uri)
                                } label: {
                                    TrackItem(track)
                                }
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
            .navigationViewStyle(.stack)
        }
    }
}

struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewController()
    }
}
