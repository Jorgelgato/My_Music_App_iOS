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
            TrackImage(track.album!.images[0].url)
                .frame(width: 100, height: 100)
            VStack(alignment: .leading, spacing: 8) {
                Text(track.name)
                    .font(.title3.bold())
                    .foregroundColor(.primary)
                    .colorInvert()
                Text(artistsString(artists: track.artists))
                    .font(.title3)
                    .foregroundColor(.primary)
                    .colorInvert()
            }
            .padding(4)
            Spacer()
        }
        .frame(height: 100)
        .background(Color("AccentColor"))
    }
}
