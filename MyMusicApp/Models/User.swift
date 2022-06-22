//
//  User.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 10/06/22.
//

import Foundation

struct User: Codable {
    let country: String
    let display_name: String
    let explicit_content: [String: Bool]
    let external_urls: [String: String]
    //let followers: [String: Codable?]
    let id: String
    let images: [UserImage]
    let product: String
}

struct UserImage: Codable {
    let url: String
}
