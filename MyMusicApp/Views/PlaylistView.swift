//
//  PlaylistView.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 24/06/22.
//

import Foundation
import SwiftUI

struct PlaylistView: View {
    let playlist: PlaylistModel
    
    init(_ palylist: PlaylistModel) {
        self.playlist = palylist
    }
    
    var body: some View {
        VStack {
            TrackImage(playlist.images[0].url)
                .frame(width: 360, height: 360)
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(playlist.description)
                    Spacer()
                }
                HStack {
                    Text(playlist.owner.display_name!)
                    Spacer()
                }
                HStack(spacing: 0) {
                    if playlist.followers != nil {
                        Text(likesFormatter(likes: playlist.followers!.total!) + " • ")
                    }
                    Text(playlistDuration(items: playlist.tracks.items))
                    Spacer()
                }
                HStack {
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Image(systemName: "ellipsis")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30, alignment: .center)
                        .rotationEffect(Angle(degrees: 90))
                    Spacer()
                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(.white, Color("AccentColor"))
                }
                .padding(.horizontal)
            }
            if playlist.tracks.items.count > 0 {
                ForEach(playlist.tracks.items, id: \.self) { item in
                    TrackView(item.track)
                }
            }
            Spacer()
        }
        .padding()
    }
}
