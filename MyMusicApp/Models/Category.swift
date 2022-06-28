//
//  Category.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 28/06/22.
//

import Foundation

struct CategoriesResponse: Codable {
    let categories: CategoryResponse
}

struct CategoryResponse: Codable {
    let href: String
    let items: [CategoryModel]
    let limit: Int
    let next: String?
    let offset: Int
    let previous: String?
    let total: Int
}

struct CategoryModel: Codable, Hashable {
    let href: String
    let icons: [ImageModel]
    let id: String
    let name: String
}
