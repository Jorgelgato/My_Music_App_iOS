//
//  Playlist.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 10/06/22.
//

import Foundation

struct FeaturedPlaylistsResponse: Codable {
    let playlists: PlaylistsResponse
}

struct PlaylistsResponse: Codable {
    let href: String
    let items: [PlaylistModel]
    let limit: Int
    let next: String?
    let offset: Int
    let previous: String?
    let total: Int
}

struct PlaylistModel: Codable {
    let collaborative: Bool
    let description: String
    //let external_urls: ExternalUrls
    let href: String
    let id: String
    let images: [ImageModel]
    let name: String
    let owner: UserModel
    //let primary_color: Any?
    let `public`: Bool?
    let snapshot_id: String
    let tracks: TotalsModel
    let type: String
    let uri: String
}
