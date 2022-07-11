//
//  NewReleasesView.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 24/06/22.
//

import Foundation
import SwiftUI

struct ReleaseItem: View {
    let album: AlbumModel
    
    init(_ album: AlbumModel) {
        self.album = album
    }
    
    var body: some View {
        HStack {
            LoadImage(album.images[0].url)
                .frame(width: 120, height: 120)
            VStack(alignment: .leading, spacing: 8) {
                Text(album.name)
                    .lineLimit(1)
                    .font(.title3.bold())
                Text(artistsString(artists: album.artists))
                    .lineLimit(1)
                    .font(.title3)
            }
            .padding(4)
            Spacer()
        }
        .frame(width: 320, height: 120)
        .background(Color("Background"))
        .padding(10)
    }
}
