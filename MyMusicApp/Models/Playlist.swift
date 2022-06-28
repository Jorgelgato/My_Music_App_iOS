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
    let items: [PlaylistsModel]
    let limit: Int
    let next: String?
    let offset: Int
    let previous: String?
    let total: Int
}

struct PlaylistsModel: Codable, Hashable {
    let collaborative: Bool
    let description: String
    //let external_urls: ExternalUrls
    let href: String
    let id: String
    let images: [ImageModel]
    let name: String
    let owner: UserModel
    //let primary_color: String?
    let `public`: Bool?
    let snapshot_id: String
    let tracks: TrackResponse
    let type: String
    let uri: String
}

struct PlaylistModel: Codable {
    let collaborative: Bool
    let description: String
//    let external_urls: ExternalUrls
    let followers: TotalsModel?
    let href: String
    let id: String
    let images: [ImageModel]
    let name: String
    let owner: UserModel
    //let primary_color: String?
    let `public`: Bool?
    let snapshot_id: String
    let tracks: PlaylistTracksModel
    let type: String
    let uri: String
}

struct PlaylistTracksModel: Codable {
    let href: String
    let items: [PlaylistItemModel]
    let limit: Int
    let next: String?
    let offset: Int
    let previous: String?
    let total: Int
}

struct PlaylistItemModel: Codable, Hashable {
//    let added_at: Date
    let added_by: UserModel
    let is_local: Bool
//    let primary_color: Any?
    let track: TrackModel
//    let video_thumbnail = Any?
}
