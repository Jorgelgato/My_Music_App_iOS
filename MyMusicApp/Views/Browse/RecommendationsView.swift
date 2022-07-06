//
//  RecommendationsView.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 24/06/22.
//

import Foundation
import SwiftUI

struct TrackItem: View {
    let track: TrackModel
    
    init(_ track: TrackModel) {
        self.track = track
    }
    
    var body: some View {
        HStack {
            LoadImage(track.album!.images[0].url)
                .frame(width: 100, height: 100)
            VStack(alignment: .leading, spacing: 8) {
                Text(track.name)
                    .font(.title3.bold())
                    .foregroundColor(.primary)
                    .colorInvert()
                    .lineLimit(1)
                Text(artistsString(artists: track.artists))
                    .font(.title3)
                    .foregroundColor(.primary)
                    .colorInvert()
                    .lineLimit(1)
            }
            .padding(4)
            Spacer()
        }
        .frame(height: 100)
        .background(Color("AccentColor"))
    }
}
