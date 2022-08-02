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
    @State var favorites: [Bool]
    var play: (_ uri: String, _ offset: Int) -> Void
    
    init(_ palylist: PlaylistModel,_ favorites: [Bool], play: @escaping (_ uri: String,_ offset: Int) -> Void) {
        self.playlist = palylist
        self.favorites = favorites
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
                        play(playlist.uri, 0)
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
                ForEach(Array(playlist.tracks.items.enumerated()), id: \.element) { index, item in
                    Button {
                        play(playlist.uri, index)
                    } label: {
                        TrackView(item.track, favorites[index]) {
                            PlayerViewModel.shared.removeTrack(trackId: item.track.id)
                            self.favorites[index] = false
                        }
                    }
                }
            }
            Spacer()
        }
        .padding()
    }
}
