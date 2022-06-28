//
//  PlaylistView.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 24/06/22.
//

import Foundation
import SwiftUI

struct PlaylistView: View {
    let palylist: PlaylistModel
    
    init(_ palylist: PlaylistModel) {
        self.palylist = palylist
    }
    
    var body: some View {
        VStack {
            TrackImage(palylist.images[0].url)
                .frame(width: 360, height: 360)
            if palylist.tracks.items.count > 0 {
                ForEach(palylist.tracks.items, id: \.self) { item in
                    TrackView(item.track)
                }
            }
            Spacer()
        }
        .padding()
    }
}
