//
//  PlaylistViewController.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 10/06/22.
//

import SwiftUI

struct PlaylistViewController: View {
    var id: String
    @StateObject private var playlistVM: PlaylistViewModel = PlaylistViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                if (playlistVM.playlist != nil && (playlistVM.playlist!.tracks.items.count == playlistVM.favorites.count)) {
                    PlaylistView(playlistVM.playlist!, playlistVM.favorites) { uri, offset in
                        playlistVM.startPlayback(playlistUri: uri, offset: offset)
                    }
                } else {
                    ProgressView()
                }
            }
        }
        .navigationTitle(playlistVM.playlist?.name ?? "")
        .onAppear {
            playlistVM.getPlaylist(id: id)
        }
    }
}

struct PlaylistViewController_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistViewController(id: "")
    }
}
