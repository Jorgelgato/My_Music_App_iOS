//
//  LibraryViewController.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 10/06/22.
//

import SwiftUI

struct LibraryViewController: View {
    @StateObject private var userViewModel: UserViewModel = UserViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(userViewModel.playlists, id: \.self) { playlist in
                        NavigationLink(destination: PlaylistViewController(id: playlist.id)) {
                            SearchItem(.playlist, .small,
                                       image: playlist.images[0].url,
                                       title: playlist.name,
                                       owner: playlist.owner.display_name ?? ""
                            )
                        }
                    }
                    ForEach(userViewModel.albums, id: \.self) { item in
                        NavigationLink(destination: AlbumViewController(id: item.album.id)) {
                            SearchItem(.album, .small,
                                       image: item.album.images[0].url,
                                       title: item.album.name,
                                       owner: artistsString(artists: item.album.artists)
                            )
                        }
                    }
                    ForEach(userViewModel.artists, id: \.self) { artist in
                        //NavigationLink(destination: ArtistViewController(id: artist.id)) {
                            SearchItem(.artist, .small,
                                       image: artist.images?.count ?? 0 > 0 ? artist.images![0].url : "error",
                                       title: artist.name
                            )
                        //}
                    }
                }
            }
            .padding(.horizontal, 10)
            .navigationBarTitle("Library")
            .onAppear {
                userViewModel.loadUserPlaylists()
                userViewModel.loadUserAlbums()
                userViewModel.loadUserFollowingArtists()
            }
        }
    }
}


struct LibraryViewController_Previews: PreviewProvider {
    static var previews: some View {
        LibraryViewController()
    }
}
