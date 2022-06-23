//
//  HomeViewController.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 10/06/22.
//

import SwiftUI

struct HomeViewController: View {
    @State private var showingSheet = false
    @State private var albums: [AlbumModel] = []
    @State private var playlists: [PlaylistModel] = []
    @State private var recomendations: [TrackModel] = []
    private var threeColumnGrid = [GridItem(.fixed(130)), GridItem(.fixed(130)), GridItem(.fixed(130))]
    private var twoColumnGrid = [GridItem(.fixed(270)), GridItem(.fixed(270))]
    
    var body: some View {
        NavigationView {
            ScrollView {
                //MARK: New releases
                Text("New Releases")
                    .font(.title.bold())
                ScrollView(.horizontal) {
                    LazyHGrid(rows: threeColumnGrid) {
                        ForEach (albums) { album in
                            Release(album)
                        }
                    }
                }
                .padding(.horizontal, 10)
                
                //MARK: Playlists
                Text("Featured Playlists")
                    .font(.title.bold())
                ScrollView(.horizontal) {
                    LazyHGrid(rows: twoColumnGrid) {
                        ForEach (playlists) { playlist in
                            Playlist(playlist)
                        }
                    }
                }
                .padding(.horizontal, 10)
                
                //MARK: Recomendations
                Text("Recomendations")
                    .font(.title.bold())
                ScrollView(.horizontal) {
                    LazyHGrid(rows: threeColumnGrid) {
                        ForEach (recomendations) { track in
                            Track(track)
                        }
                    }
                }
                .padding(.horizontal, 10)
                    
            }
            .navigationBarTitle("Browse")
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
        .onAppear {
            APICaller.shared.getNewReleases { result in
                switch result {
                case .success(let model):
                    albums = model.albums.items
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }
            
            APICaller.shared.getFeaturedPlaylists { result in
                switch result {
                case .success(let model):
                    playlists = model.playlists.items
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }
            
            APICaller.shared.getGenresSeeds { result in
                switch result {
                case .success(let model):
                    let genres = model.genres
                    var seeds = Set<String>()
                    while seeds.count < 5 {
                        if let random = genres.randomElement() {
                            seeds.insert(random)
                        }
                    }
                    APICaller.shared.getRecommendations(genres: seeds) { result in
                        switch result {
                        case .success(let model):
                            recomendations = model.tracks
                            break
                        case .failure(let error):
                            print(error)
                            break
                        }
                    }
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }
        }
    }
    
    struct Release: View {
        let album: AlbumModel
        
        init(_ album: AlbumModel) {
            self.album = album
        }
        
        var body: some View {
            HStack {
                TrackImage(album.images[0].url)
                    .frame(width: 120, height: 120)
                VStack(alignment: .leading, spacing: 8) {
                    Text(album.name)
                        .font(.title3.bold())
                    Text(artistsString(artists: album.artists))
                        .font(.title3)
                }
                .padding(4)
                Spacer()
            }
            .frame(width: 320, height: 120)
            .background(.purple)
            .padding(10)
        }
        
        func artistsString(artists: [ArtistModel]) -> String {
            var string = ""
            for artist in artists {
                string.append(artist.name + ", ")
            }
            string.removeLast()
            string.removeLast()
            return string
        }
    }
    
    struct Playlist: View {
        let playlist: PlaylistModel
        
        init(_ playlist: PlaylistModel) {
            self.playlist = playlist
        }
        
        var body: some View {
            VStack(alignment: .leading ,spacing: 2) {
                TrackImage(playlist.images[0].url)
                    .frame(width: 240, height: 240)
                Text(playlist.name)
                    .bold()
            }
            .padding(10)
        }
    }
    
    struct Track: View {
        let track: TrackModel
        
        init(_ track: TrackModel) {
            self.track = track
        }
        
        var body: some View {
            HStack {
                TrackImage(track.album.images[0].url)
                    .frame(width: 120, height: 120)
                VStack(alignment: .leading, spacing: 8) {
                    Text(track.name)
                        .font(.title3.bold())
                    Text(artistsString(artists: track.artists))
                        .font(.title3)
                }
                .padding(4)
                Spacer()
            }
            .frame(width: 320, height: 120)
            .background(.purple)
            .padding(10)
        }
        
        func artistsString(artists: [ArtistModel]) -> String {
            var string = ""
            for artist in artists {
                string.append(artist.name + ", ")
            }
            string.removeLast()
            string.removeLast()
            return string
        }
    }
}

struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewController()
    }
}
