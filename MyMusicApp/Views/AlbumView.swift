//
//  AlbumView.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 24/06/22.
//

import Foundation
import SwiftUI

struct AlbumView: View {
    let album: AlbumModel
    let artist: ArtistModel
    @State var favorites: [Bool]
    var play: (_ uri: String, _ offset: Int) -> Void
    
    init(_ album: AlbumModel,_ artist: ArtistModel,_ favorites: [Bool], play: @escaping (_ uri: String,_ offset: Int) -> Void) {
        self.album = album
        self.artist = artist
        self.favorites = favorites
        self.play = play
    }
    
    var body: some View {
        VStack {
            LoadImage(album.images[0].url)
                .frame(width: 360, height: 360)
            VStack(alignment: .leading, spacing: 10) {
                if album.artists.count > 1 {
                    Text("\(album.artists[0].name) + \(album.artists.count)")
                        .foregroundColor(.secondary)
                        .bold()
                } else {
                    NavigationLink(destination: ArtistViewController(artist: artist)) {
                        HStack {
                            LoadImage(artist.images?[0].url ?? "error")
                                .frame(width: 20, height: 20)
                                .clipShape(Circle())
                            Text(album.artists[0].name)
                                .bold()
                        }
                    }
                }
                
                Text(album.album_type.capitalized + " • " + album.release_date.split(separator: "-")[0])
                
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
                        play(album.uri, 0)
                    } label: {
                        Image(systemName: "play.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundStyle(.white, Color("Primary"))
                    }
                }
                .padding(.horizontal)
            }
            if album.tracks?.items?.count ?? 0 > 0 {
                ForEach(Array(album.tracks!.items!.enumerated()), id: \.element) { index, track in
                    Button {
                        play(album.uri, index)
                    } label: {
                        TrackView(track, favorites[index]) {
                            PlayerViewModel.shared.removeTrack(trackId: track.id)
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
