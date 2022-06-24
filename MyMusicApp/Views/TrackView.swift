//
//  TrackViewe.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 24/06/22.
//

import Foundation
import SwiftUI

struct TrackView: View {
    var track: TrackModel
    init (_ track: TrackModel) {
        self.track = track
    }
    var body: some View {
        HStack(spacing: 24) {
            VStack(alignment: .leading) {
                Text(track.name)
                    .lineLimit(1)
                HStack {
                    if track.explicit {
                        Image(systemName: "e.square.fill")
                    }
                    Text(artistsString(artists: track.artists))
                        .lineLimit(1)
                }
            }
            Spacer()
            Image(systemName: "heart")
            Image(systemName: "slider.horizontal.3")
        }
        .padding(8)
    }
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
