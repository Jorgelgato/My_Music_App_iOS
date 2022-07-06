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
            Image(systemName: "ellipsis")
                .rotationEffect(.degrees(90))
        }
        .padding(8)
    }
}

struct ArtistTrackView: View {
    var track: TrackModel
      
    init (_ track: TrackModel) {
        self.track = track
    }
    var body: some View {
        HStack {
            LoadImage(track.album?.images[0].url ?? "error")
                .frame(width: Size.tiny.rawValue, height: Size.tiny.rawValue)
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
                .padding(.horizontal, 24)
            Image(systemName: "ellipsis")
                .rotationEffect(.degrees(90))
        }
        .padding(8)
    }
}
