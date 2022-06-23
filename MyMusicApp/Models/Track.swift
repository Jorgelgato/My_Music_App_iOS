//
//  Track.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 10/06/22.
//

import Foundation

struct RecommendationsResponse: Codable {
//    let seeds: [Seed]
    let tracks: [TrackModel]
}

struct TrackModel: Codable {
    let album: AlbumModel
    let artists: [ArtistModel]
    let available_markets: [String]?
    let disk_number: Int?
    let duration_ms: Int
    let explicit: Bool
//    let external_ids: Any
//    let external_urls: ExternalUrls
    let href: String
    let id: String
    let is_playable: Bool?
    let is_local: Bool
    let name: String
    let popularity: Int
//    let preview_url: Any?
    let track_number: Int
    let type: String
    let uri: String
    
}
