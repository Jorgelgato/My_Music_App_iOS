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
    @StateObject var playervm = PlayerViewVM.shared
    
    var body: some View {
        VStack(spacing: 0) {
            if playervm.track != nil {
                Spacer()
                LoadImage(playervm.track!.album!.images.count > 0 ? playervm.track!.album!.images[0].url : "error")
                    .frame(width: 360, height: 360)
                HStack {
                    VStack(alignment: .leading) {
                        Text(playervm.track!.name)
                            .lineLimit(1)
                            .font(.title.bold())
                        Text(artistsString(artists: playervm.track!.artists))
                            .lineLimit(1)
                            .font(.title2)
                    }
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "heart")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color("AccentColor"))
                    }
                }
                .padding()
                Spacer()
                
                VStack {
                    ProgressView(value: 0)
                    HStack {
                        Text("0:00")
                        Spacer()
                        Text(trackDuration(duration: playervm.track!.duration_ms))
                    }
                }
                .padding()
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "shuffle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color("AccentColor"))
                    }
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "backward.end.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color("AccentColor"))
                    }
                    Spacer()
                    Button {
                        playervm.togglePlayback()
                    } label: {
                        Image(systemName: playervm.playing ? "pause.circle.fill" : "play.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundStyle(.background, Color("AccentColor"))
                    }
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "forward.end.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color("AccentColor"))
                    }
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "arrow.rectanglepath")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color("AccentColor"))
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
    @StateObject var playervm = PlayerViewVM.shared
    
    var body: some View {
        VStack {
            if playervm.player != nil && playervm.track != nil {
                Spacer()
                HStack {
                    LoadImage(playervm.track!.album!.images[0].url)
                        .frame(width: 40, height: 40)
                    Text("\(playervm.track!.name) • \(artistsString(artists: playervm.track!.artists)) ")
                        .font(.body.bold())
                        .foregroundColor(.primary)
                        .colorInvert()
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "heart")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.primary)
                            .colorInvert()
                    }
                    Button {
                        playervm.togglePlayback()
                    } label: {
                        Image(systemName: playervm.playing ? "pause" : "play")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.primary)
                            .colorInvert()
                    }
                    .padding(.horizontal, 10)
                }
                .padding(10)
                .background(Color("AccentColor").opacity(0.8))
                .clipped()
            }
        }
        .onTapGesture {
            playervm.showing.toggle()
        }
        .sheet(isPresented: $playervm.showing) {
            PlayerViewController()
        }
        .alert("Cannot play this song", isPresented: $playervm.error) {
            Button("OK", role: .cancel) { }
        }
    }
}
