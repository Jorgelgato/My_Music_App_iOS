//
//  AlbumViewVM.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 24/06/22.
//

import Foundation

class AlbumViewModel: ObservableObject {
    
    @Published var album: AlbumModel? = nil
    
    @Published var artist: ArtistModel? = nil
    
    @Published var favorites: [Bool] = []
    
    func getAlbum(id: String) {
        APICaller.shared.getAlbum(id: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.checkSavedTrack(items: model.tracks!.items!)
                    self.getArtist(id: model.artists[0].id)
                    self.album = model
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
    
    func checkSavedTrack(items: [TrackModel]) {
        self.favorites = []
        var trackids: [String] = []
        
        for item in items {
            trackids.append(item.id)
        }
        
        let tracks = trackids.chunked(into: 50)
        
        for track in tracks {
            APICaller.shared.getSavedTracks(tracks: track) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let model):
                        self.favorites.append(contentsOf:model)
                        break
                    case .failure(_):
                        break
                    }
                }
            }
        }
    }
}
