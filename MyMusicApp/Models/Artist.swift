//
//  Artist.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 10/06/22.
//

import Foundation

struct ArtistModel: Codable {
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
