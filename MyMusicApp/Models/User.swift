//
//  User.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 10/06/22.
//

import Foundation

struct UserModel: Codable, Hashable {
    let country: String?
    let display_name: String?
    let email: String?
    let explicit_content: [String: Bool]?
//    let external_urls: ExternalUrls
    let followers: TotalsModel?
    let href: String
    let id: String
    let images: [ImageModel]?
    let product: String?
    let type: String
    let uri: String
}
