//
//  NewReleasesView.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 24/06/22.
//

import Foundation
import SwiftUI

struct Release: View {
    let album: AlbumModel
    
    init(_ album: AlbumModel) {
        self.album = album
    }
    
    var body: some View {
        HStack {
            TrackImage(album.images[0].url)
                .frame(width: 120, height: 120)
            VStack(alignment: .leading, spacing: 8) {
                Text(album.name)
                    .font(.title3.bold())
                    .foregroundColor(.primary)
                    .colorInvert()
                Text(artistsString(artists: album.artists))
                    .font(.title3)
                    .foregroundColor(.primary)
                    .colorInvert()
            }
            .padding(4)
            Spacer()
        }
        .frame(width: 320, height: 120)
        .background(Color("AccentColor"))
        .padding(10)
    }
    
    func artistsString(artists: [ArtistModel]) -> String {
        var string = ""
        for artist in artists {
            string.append(artist.name + ", ")
        }
        string.removeLast()
        string.removeLast()
        return string
    }
}
