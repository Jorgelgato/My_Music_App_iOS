//
//  FeaturedPlaylistsView.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 24/06/22.
//

import Foundation
import SwiftUI

struct PlaylistItem: View {
    let playlist: PlaylistsModel
    let size: Size
    
    init(_ playlist: PlaylistsModel, size: Size = .big) {
        self.playlist = playlist
        self.size = size
    }
    
    var body: some View {
        VStack(alignment: .leading ,spacing: 2) {
            LoadImage(playlist.images.count > 0 ? playlist.images[0].url : "error")
                .frame(width: size.rawValue, height: size.rawValue)
            Text(playlist.name)
                .bold()
        }
        .padding(10)
    }
}

