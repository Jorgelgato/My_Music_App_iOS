//
//  AlbumView.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 24/06/22.
//

import Foundation
import SwiftUI

struct AlbumView: View {
    let album: AlbumModel
    
    init(_ album: AlbumModel) {
        self.album = album
    }
    
    var body: some View {
        VStack {
            TrackImage(album.images[0].url)
                .frame(width: 360, height: 360)
            if album.tracks?.items?.count ?? 0 > 0 {
                ForEach(album.tracks!.items!, id: \.self)  { track in
                    TrackView(track)
                }
            }
            Spacer()
        }
        .padding()
    }
}
