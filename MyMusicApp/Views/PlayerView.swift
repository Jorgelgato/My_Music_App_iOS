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
                .padding(40)
                
                Spacer()
                LoadImage(playervm.player!.context.metadata.current_item!.images.count > 0 ? playervm.player!.context.metadata.current_item!.images[0].url : "error")
                    .frame(width: 360, height: 360)
                HStack {
                    VStack(alignment: .leading) {
                        Text(playervm.player!.context.metadata.current_item!.name)
                            .lineLimit(1)
                            .font(.title.bold())
                        Text(artistsString(artists: playervm.player!.context.metadata.current_item!.artists))
                            .lineLimit(1)
                            .font(.title2)
                    }
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "heart")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                }
                .padding()
                Spacer()
                
                VStack {
                    ProgressView(value: 0)
                    HStack {
                        Text("0:00")
                        Spacer()
                        Text(trackDuration(duration: playervm.player!.duration))
                    }
                }
                .padding()
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "shuffle")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "backward.end.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
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
                    Button {
                        
                    } label: {
                        Image(systemName: "forward.end.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
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
            if playervm.player != nil {
                Spacer()
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
                    Button {
                        
                    } label: {
                        Image(systemName: "heart")
                            .resizable()
                            .frame(width: 20, height: 20)
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
