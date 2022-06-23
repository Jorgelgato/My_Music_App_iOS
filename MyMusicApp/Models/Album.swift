//
//  Album.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 23/06/22.
//

import Foundation

struct NewReleasesResponse: Codable {
    let albums: AlbumResponse
}

struct AlbumResponse: Codable {
    let href: String
    let items: [AlbumModel]
    let limit: Int
    let next: String
    let offset: Int
    let previous: String?
    let total: Int
}

struct AlbumModel: Codable {
    let album_type: String
    let artists: [ArtistModel]
    let available_markets: [String]
    //let external_urls: ExternalUrls
    let href: String
    let id: String
    let images: [ImageModel]
    let name: String
    let release_date: String
    let release_date_precision: String
    //let restrictions: Any
    let total_tracks: Int
    let type: String
    let uri: String
}
