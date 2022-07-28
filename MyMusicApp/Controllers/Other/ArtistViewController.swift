//
//  ArtistViewController.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 6/07/22.
//

import SwiftUI

struct ArtistViewController: View {
    var artist: ArtistModel?
    @StateObject private var artistViewVM: ArtistViewVM = ArtistViewVM()
    
    var body: some View {
        ScrollView {
            if (artist != nil) {
                ArtistView(artist!)
                if artistViewVM.tracks.count > 0 {
                    VStack(alignment: .leading) {
                        Text("Popular")
                            .font(.title3.bold())
                            .padding(.leading, 8)
                        ForEach(artistViewVM.tracks, id: \.self) { track in
                            Button {
                                PlayerViewModel.shared.startPlayback(trackUri: track.uri)
                            } label: {
                                ArtistTrackView(track)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle(artist?.name ?? "")
        .onAppear {
            artistViewVM.getArtistTopTracks(id: artist!.id)
        }
    }
}

struct ArtistViewController_Previews: PreviewProvider {
    static var previews: some View {
        ArtistViewController(artist: nil)
    }
}
