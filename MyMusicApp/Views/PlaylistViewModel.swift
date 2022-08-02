//
//  PlaylistViewVM.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 24/06/22.
//

import Foundation

class PlaylistViewModel: ObservableObject {
    
    @Published var playlist: PlaylistModel? = nil
    
    @Published var favorites: [Bool] = []
    
    func getPlaylist(id: String) {
        APICaller.shared.getPlaylist(id: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.checkSavedTrack(items: model.tracks.items)
                    self.playlist = model
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }
        }
    }
    
    func startPlayback(playlistUri: String, offset: Int) {
        APICaller.shared.putPlayContextUri(device: AuthManager.shared.deviceID!, context: playlistUri, offset: offset) { result in
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
    
    func checkSavedTrack(items: [PlaylistItemModel]) {
        self.favorites = []
        var trackids: [String] = []
        
        for item in items {
            trackids.append(item.track.id)
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
