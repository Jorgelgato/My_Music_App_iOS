//
//  Artist.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 10/06/22.
//

import Foundation

struct ArtistResponse: Codable {
    let href: String
    let items: [ArtistModel]
    let limit: Int
    let next: String
    let offset: Int
    let previous: String?
    let total: Int
}

struct ArtistModel: Codable, Hashable {
//    let external_urls: ExternalUrls
    let followers: TotalsModel?
    let genres: [String]?
    let href: String
    let id: String
    let images: [ImageModel]?
    let name: String
    let popularity: Int?
    let type: String
    let uri: String
}
