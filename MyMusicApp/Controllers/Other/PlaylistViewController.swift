//
//  PlaylistViewController.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 10/06/22.
//

import SwiftUI

struct PlaylistViewController: View {
    var id: String
    @StateObject private var playlistViewVM: PlaylistViewVM = PlaylistViewVM()
    
    var body: some View {
        ScrollView {
            VStack {
                if (playlistViewVM.playlist != nil) {
                    PlaylistView(playlistViewVM.playlist!)
                }
            }
        }
        .navigationTitle(playlistViewVM.playlist?.name ?? "")
        .onAppear {
            playlistViewVM.getPlaylist(id: id)
        }
    }
}

struct PlaylistViewController_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistViewController(id: "")
    }
}
