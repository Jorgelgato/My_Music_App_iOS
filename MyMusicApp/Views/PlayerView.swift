//
//  PlayerView.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 29/06/22.
//

import Foundation
import SwiftUI
import AVFoundation
import AVKit

class ViewerOptions: ObservableObject {
    @Published var showTimecode = false
}

struct PlayerView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @StateObject var playervm = PlayerViewModel.shared
    
    var body: some View {
        VStack(spacing: 0) {
            if playervm.player != nil {
                HStack {
                    Button {
                        playervm.showing.toggle()
                    } label: {
                        Image(systemName: "chevron.down")
                    }
                    Spacer()
                    Text(playervm.player!.context.metadata.current_item!.name)
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis")
                            .rotationEffect(.degrees(90))
                    }
                }
                .padding(sizeClass == .compact ? 20 : 40)
                
                Spacer()
                LoadImage(playervm.player!.context.metadata.current_item!.images.count > 0 ? playervm.player!.context.metadata.current_item!.images[0].url : "error")
                    .frame(width: sizeClass == .compact ? 300 : 360, height: sizeClass == .compact ? 300 : 360)
                HStack {
                    VStack(alignment: .leading) {
                        Text(playervm.player!.context.metadata.current_item!.name)
                            .lineLimit(1)
                            .font(sizeClass == .compact ? .title2.bold() : .title.bold())
                        Text(artistsString(artists: playervm.player!.context.metadata.current_item!.artists))
                            .lineLimit(1)
                            .font(sizeClass == .compact ? .title3 : .title2)
                    }
                    Spacer()
                    if playervm.isSaved ?? false {
                        Button {
                            playervm.removeTrack(trackId: playervm.player!.track_window.current_track!.id)
                        } label: {
                            Image(systemName: "heart.fill")
                                .resizable()
                                .frame(width: 28, height: 25)
                                .foregroundColor(Color("Primary"))
                        }
                    } else {
                        Button {
                            playervm.saveTrack(trackId: playervm.player!.track_window.current_track!.id)
                        } label: {
                            Image(systemName: "heart")
                                .resizable()
                                .frame(width: 28, height: 25)
                        }
                    }
                }
                .padding()
                Spacer()
                
                VStack {
                    ProgressView(value: Double(playervm.progress), total: Double(playervm.player!.duration))
                    HStack {
                        Text(trackDuration(duration: playervm.progress))
                        Spacer()
                        Text(trackDuration(duration: playervm.player!.duration))
                    }
                }
                .padding()
                HStack {
                    Button {
                        playervm.toggleShuffle(state: !playervm.player!.shuffle)
                    } label: {
                        Image(systemName: "shuffle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(playervm.player!.shuffle ? Color("Primary") : .secondary)
                    }
                    
                    Spacer()
                    
                    DisablingButton(
                        active: playervm.player!.track_window.previous_tracks?.count ?? 0 > 0,
                        image: "backward.end.fill"
                    ) {
                        playervm.skipPrevious()
                    }
                    Spacer()
                    
                    Button {
                        playervm.player!.paused ? playervm.startPlayback() : playervm.pausePlayback()
                    } label: {
                        Image(systemName: playervm.player!.paused ? "play.circle.fill" : "pause.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    Spacer()
                    
                    DisablingButton(
                        active: playervm.player!.track_window.next_tracks?.count ?? 0 > 0,
                        image: "forward.end.fill"
                    ) {
                        playervm.skipNext()
                    }
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "arrow.rectanglepath")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                }
                .padding()
                Spacer()
            }
        }
        .padding()
    }
    
    
}

struct PlayerBar: View {
    @StateObject var playervm = PlayerViewModel.shared
    
    var body: some View {
        VStack {
            if playervm.player?.track_window.current_track != nil{
                Spacer()
                ZStack(alignment: .bottom) {
                    HStack {
                        LoadImage(playervm.player!.context.metadata.current_item!.images[0].url)
                            .frame(width: 40, height: 40)
                        VStack(alignment: .leading) {
                            Text(playervm.player!.context.metadata.current_item!.name)
                                .font(.body.bold())
                                .lineLimit(1)
                            Text(artistsString(artists: playervm.player!.context.metadata.current_item!.artists))
                                .lineLimit(1)
                        }
                        Spacer()
                        
                        if playervm.isSaved ?? false {
                            Button {
                                playervm.removeTrack(trackId: playervm.player!.track_window.current_track!.id)
                            } label: {
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .frame(width: 28, height: 25)
                                    .foregroundColor(Color("Primary"))
                            }
                        } else {
                            Button {
                                playervm.saveTrack(trackId: playervm.player!.track_window.current_track!.id)
                            } label: {
                                Image(systemName: "heart")
                                    .resizable()
                                    .frame(width: 28, height: 25)
                            }
                        }
                        
                        Button {
                            playervm.player!.paused ? playervm.startPlayback() : playervm.pausePlayback()
                        } label: {
                            Image(systemName: playervm.player!.paused ? "play" : "pause")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                        .padding(.horizontal, 10)
                    }
                    .padding(10)
                    ProgressView(value: Double(playervm.progress), total: Double(playervm.player!.duration))
                        .background(Color("Background"))
                }
                .background(Color("Background").opacity(0.9))
                .clipped()
            }
        }
        .onTapGesture {
            playervm.showing.toggle()
        }
        .sheet(isPresented: $playervm.showing) {
            PlayerViewController()
        }
    }
}


struct DisablingButton: View {
    var active: Bool
    var image: String
    var completion: () -> Void
    
    init (active: Bool, image: String, completion: @escaping () -> Void) {
        self.active = active
        self.image = image
        self.completion = completion
    }
    
    var body: some View {
        Button {
            if active {
                completion()
            }
        } label: {
            if active {
                Image(systemName: image)
                    .resizable()
                    .frame(width: 30, height: 30)
            } else {
                Image(systemName: image)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.secondary)
            }
        }
    }
}
