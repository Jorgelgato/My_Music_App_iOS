//
//  ArtistViewVM.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 6/07/22.
//

import Foundation

class ArtistViewVM: ObservableObject {
    
    @Published var tracks: [TrackModel] = []
    
    func getArtistTopTracks(id: String) {
        APICaller.shared.getArtistTopTracks(id: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.tracks = model.tracks
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }
        }
    }
}
