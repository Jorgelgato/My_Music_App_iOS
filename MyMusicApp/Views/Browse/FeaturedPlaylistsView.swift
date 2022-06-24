//
//  FeaturedPlaylistsView.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 24/06/22.
//

import Foundation
import SwiftUI

struct Playlist: View {
    let playlist: PlaylistModel
    
    init(_ playlist: PlaylistModel) {
        self.playlist = playlist
    }
    
    var body: some View {
        VStack(alignment: .leading ,spacing: 2) {
            TrackImage(playlist.images[0].url)
                .frame(width: 240, height: 240)
            Text(playlist.name)
                .bold()
        }
        .padding(10)
    }
}
