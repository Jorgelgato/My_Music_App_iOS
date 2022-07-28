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
    var play: (_ uri: String) -> Void
    
    init(_ palylist: PlaylistModel, play: @escaping (_ uri: String) -> Void) {
        self.playlist = palylist
        self.play = play
    }
    
    var body: some View {
        VStack {
            LoadImage(playlist.images?.count ?? 0 > 0 ? playlist.images![0].url : "error")
                .frame(width: 360, height: 360)
            VStack(alignment: .leading, spacing: 10) {
                
                Text(playlist.description)
                
                Text(playlist.owner.display_name!)
                
                HStack(spacing: 0) {
                    if playlist.followers != nil {
                        Text(likesFormatter(likes: playlist.followers!.total!) + " • ")
                    }
                    Text(playlistDuration(items: playlist.tracks.items))
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
                    Button {
                        play(playlist.uri)
                    } label: {
                        Image(systemName: "play.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundStyle(.white, Color("Primary"))
                    }
                }
                .padding(.horizontal)
            }
            if playlist.tracks.items.count > 0 {
                ForEach(playlist.tracks.items, id: \.self) { item in
                    Button {
                        PlayerViewModel.shared.startPlayback(trackUri: item.track.uri)
                    } label: {
                        TrackView(item.track)
                    }
                }
            }
            Spacer()
        }
        .padding()
    }
}
