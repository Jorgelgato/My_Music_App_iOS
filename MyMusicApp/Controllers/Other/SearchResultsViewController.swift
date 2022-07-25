//
//  SearchResultsViewController.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 10/06/22.
//

import SwiftUI

struct SearchResultsViewController: View {
    var search: SearchResponse?
    @State private var isTracks: Bool = true
    @State private var isAlbums: Bool = false
    @State private var isArtists: Bool = false
    @State private var isPlaylists: Bool = false
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    Button {
                        isTracks = true
                        isAlbums = false
                        isArtists = false
                        isPlaylists = false
                    } label: {
                        Text("Tracks")
                            .padding()
                            .background(Capsule().fill(isTracks ? Color("Primary") : Color("Background")))
                            .overlay(Capsule().stroke(Color.white, lineWidth: 1))
                    }
                    
                    Button {
                        isTracks = false
                        isAlbums = true
                        isArtists = false
                        isPlaylists = false
                    } label: {
                        Text("Albums")
                            .padding()
                            .background(Capsule().fill(isAlbums ? Color("Primary") : Color("Background")))
                            .overlay(Capsule().stroke(Color.white, lineWidth: 1))
                    }
                    
                    Button {
                        isTracks = false
                        isAlbums = false
                        isArtists = true
                        isPlaylists = false
                    } label: {
                        Text("Artists")
                            .padding()
                            .background(Capsule().fill(isArtists ? Color("Primary") : Color("Background")))
                            .overlay(Capsule().stroke(Color.white, lineWidth: 1))
                    }
                    
                    Button {
                        isTracks = false
                        isAlbums = false
                        isArtists = false
                        isPlaylists = true
                    } label: {
                        Text("Playlists")
                            .padding()
                            .background(Capsule().fill(isPlaylists ? Color("Primary") : Color("Background")))
                            .overlay(Capsule().stroke(Color.white, lineWidth: 1))
                    }
                }
                .padding()
            }
            
            ScrollView {
                LazyVStack {
                    if isTracks {
                        if search?.tracks?.items?.count ?? 0 > 0 {
                            ForEach(search!.tracks!.items!, id: \.self) { track in
                                Button {
                                    PlayerViewModel.shared.startPlayback(trackId: track.id)
                                } label: {
                                    SearchItem(.song,
                                               image: track.album?.images[0].url ?? "",
                                               title: track.name,
                                               owner: artistsString(artists: track.artists)
                                    )
                                }
                            }
                        } else {
                            Text("No results")
                        }
                    }
                    
                    if isAlbums {
                        if search?.albums?.items.count ?? 0 > 0 {
                            ForEach(search!.albums!.items, id: \.self) { album in
                                NavigationLink(destination: AlbumViewController(id: album.id)) {
                                    SearchItem(.album,
                                               image: album.images[0].url,
                                               title: album.name,
                                               owner: artistsString(artists: album.artists)
                                    )
                                }
                            }
                        }
                    }
                    
                    if isArtists {
                        if search?.artists?.items.count ?? 0 > 0 {
                            ForEach(search!.artists!.items, id: \.self) { artist in
                                NavigationLink(destination: ArtistViewController(artist: artist)) {
                                    SearchItem(.artist,
                                               image: artist.images?.count ?? 0 > 0 ? artist.images![0].url : "error",
                                               title: artist.name
                                    )
                                }
                            }
                        }
                    }
                    
                    if isPlaylists {
                        if search?.playlists?.items.count ?? 0 > 0 {
                            ForEach(search!.playlists!.items, id: \.self) { playlist in
                                NavigationLink(destination: PlaylistViewController(id: playlist.id)) {
                                    SearchItem(.playlist,
                                               image: playlist.images[0].url,
                                               title: playlist.name,
                                               owner: playlist.owner.display_name ?? ""
                                    )
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}



struct SearchResultsViewController_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsViewController(search: nil)
    }
}
