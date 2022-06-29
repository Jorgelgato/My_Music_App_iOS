//
//  SearchResultsViewController.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 10/06/22.
//

import SwiftUI

struct SearchResultsViewController: View {
    var search: SearchResponse?
    
    var body: some View {
        LazyVStack {
            if search?.artists?.items.count ?? 0 > 0 {
                ForEach(search!.artists!.items, id: \.self) { artist in
                    SearchItem(.artist,
                               image: artist.images?.count ?? 0 > 0 ? artist.images![0].url : "error",
                               title: artist.name
                    )
                }
            }
            
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
            
            if search?.tracks?.items?.count ?? 0 > 0 {
                ForEach(search!.tracks!.items!, id: \.self) { track in
                    SearchItem(.song,
                               image: track.album?.images[0].url ?? "",
                               title: track.name,
                               owner: artistsString(artists: track.artists)
                    )
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
