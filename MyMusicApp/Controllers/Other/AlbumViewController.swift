//
//  AlbumViewController.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 24/06/22.
//

import SwiftUI

struct AlbumViewController: View {
    var id: String
    @StateObject private var albumViewVM: AlbumViewVM = AlbumViewVM()
    
    var body: some View {
        ScrollView {
            VStack {
                if (albumViewVM.album != nil && albumViewVM.artist != nil) {
                    AlbumView(albumViewVM.album!, albumViewVM.artist!) { uri, offset in
                        albumViewVM.startPlayback(albumUri: uri, offset: offset)
                    }
                }
            }
        }
        .navigationTitle(albumViewVM.album?.name ?? "")
        .onAppear {
            albumViewVM.getAlbum(id: id)
        }
    }
}

struct AlbumViewController_Previews: PreviewProvider {
    static var previews: some View {
        AlbumViewController(id: "")
    }
}
