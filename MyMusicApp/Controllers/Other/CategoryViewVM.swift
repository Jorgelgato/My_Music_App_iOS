//
//  CategoryViewVM.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 28/06/22.
//

import Foundation

class CategoryViewVM: ObservableObject {
    
    @Published var playlists: [PlaylistsModel] = []
    
    func getCategory(id: String) {
        APICaller.shared.getCategory(id: id) { result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    print(model)
                    self.playlists = model.playlists.items
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
