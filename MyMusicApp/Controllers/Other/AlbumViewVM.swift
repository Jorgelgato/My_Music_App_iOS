//
//  AlbumViewVM.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 24/06/22.
//

import Foundation

class AlbumViewVM: ObservableObject {
    
    @Published var album: AlbumModel? = nil
    
    @Published var artist: ArtistModel? = nil
    
    func getAlbum(id: String) {
        APICaller.shared.getAlbum(id: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.album = model
                    self.getArtist(id: self.album!.artists[0].id)
                    break
                case .failure(_):
                    break
                }
            }
        }
    }
    
    func getArtist(id: String) {
        APICaller.shared.getArtist(id: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.artist = model
                    break
                case .failure(_):
                    break
                }
            }
        }
    }
    
    func startPlayback(albumUri: String, offset: Int) {
        APICaller.shared.putPlayContextUri(device: AuthManager.shared.deviceID!, context: albumUri, offset: offset) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    break
                case .failure(_):
                    break
                }
            }
        }
    }
}
