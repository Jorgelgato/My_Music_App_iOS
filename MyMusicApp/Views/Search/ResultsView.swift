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
    
    init(_ type: ItemType, image: String, title: String, owner: String = "") {
        self.type = type
        self.image = image
        self.title = title
        self.owner = owner
    }
    
    var body: some View {
        HStack {
            switch type {
            case .artist:
                LoadImage(image)
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
                Text(title)
                    .font(.title3.bold())
                    .foregroundColor(.primary)
                    .colorInvert()
                    .padding(4)
                
            case .album, .playlist, .song:
                LoadImage(image)
                    .frame(width: 70, height: 70)
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .lineLimit(1)
                        .font(.title3.bold())
                        .foregroundColor(.primary)
                        .colorInvert()
                    Text("\(type.rawValue) • \(owner)")
                        .lineLimit(1)
                        .font(.title3)
                        .foregroundColor(.primary)
                        .colorInvert()
                }
                .padding(4)
            }
            Spacer()
        }
        .frame(height: 70)
        .background(Color("AccentColor"))
    }
}

enum ItemType: String {
    case artist = "Artist"
    case album = "Album"
    case playlist = "Playlist"
    case song = "Song"
}
