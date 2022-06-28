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
}
