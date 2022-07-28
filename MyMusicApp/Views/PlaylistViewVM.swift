//
//  PlaylistViewVM.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 24/06/22.
//

import Foundation

class PlaylistViewVM: ObservableObject {
    
    @Published var playlist: PlaylistModel? = nil
    
    func getPlaylist(id: String) {
        APICaller.shared.getPlaylist(id: id) { result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self.playlist = model
                }
                break
            case .failure(let error):
                print(error)
                break
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
}
