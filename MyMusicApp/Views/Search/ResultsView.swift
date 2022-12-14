//
//  ResultsView.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 29/06/22.
//

import Foundation
import SwiftUI

struct SearchItem: View {
    let type: ItemType
    let image: String
    let title: String
    let owner: String
    let size: Size
    
    init(_ type: ItemType, _ size: Size = .small, image: String, title: String, owner: String = "") {
        self.type = type
        self.size = size
        self.image = image
        self.title = title
        self.owner = owner
    }
    
    var body: some View {
        switch type {
        case .artist:
            HStack {
                LoadImage(image)
                    .frame(width: size.rawValue, height: size.rawValue)
                    .clipShape(Circle())
                Text(title)
                    .font(.title3.bold())
                    .padding(4)
                Spacer()
            }
            .frame(height: size.rawValue)
            
        case .album, .playlist, .song:
            HStack {
                LoadImage(image)
                    .frame(width: size.rawValue, height: size.rawValue)
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .lineLimit(1)
                        .font(.title3.bold())
                    Text("\(type.rawValue) • \(owner)")
                        .lineLimit(1)
                        .font(.title3)
                }
                .padding(4)
                Spacer()
            }
            .frame(height: size.rawValue)
            .background(Color("Background"))
        }
    }
}
