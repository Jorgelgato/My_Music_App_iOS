//
//  Search.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 29/06/22.
//

import Foundation

struct SearchResponse: Codable {
    let artists: ArtistResponse?
    let albums: AlbumResponse?
    let tracks: TrackResponse?
    let playlists: PlaylistsResponse?
}
