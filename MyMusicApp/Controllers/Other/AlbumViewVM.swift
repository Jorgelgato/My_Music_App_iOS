//
//  AlbumViewVM.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 24/06/22.
//

import Foundation

class AlbumViewVM: ObservableObject {
    
    @Published var album: AlbumModel? = nil
    
    func getAlbum(id: String) {
        APICaller.shared.getAlbum(id: id) { result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self.album = model
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
