//
//  AlbumViewController.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 24/06/22.
//

import SwiftUI

struct AlbumViewController: View {
    var id: String
    @StateObject private var albumVM: AlbumViewModel = AlbumViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                if (albumVM.album != nil && albumVM.artist != nil && (albumVM.album!.tracks!.items!.count == albumVM.favorites.count)) {
                    AlbumView(albumVM.album!, albumVM.artist!, albumVM.favorites) { uri, offset in
                        albumVM.startPlayback(albumUri: uri, offset: offset)
                    }
                }
            }
        }
        .navigationTitle(albumVM.album?.name ?? "")
        .onAppear {
            albumVM.getAlbum(id: id)
        }
    }
}

struct AlbumViewController_Previews: PreviewProvider {
    static var previews: some View {
        AlbumViewController(id: "")
    }
}
