//
//  HomeViewVM.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 24/06/22.
//

import Foundation

class HomeViewVM: ObservableObject {
    
    @Published var albums: [AlbumModel] = []
    @Published var playlists: [PlaylistModel] = []
    @Published var recomendations: [TrackModel] = []
    
    init() {
        getNewReleases()
        getFeaturedPlaylists()
        getRecommendations()
    }
    
    func getNewReleases() {
        APICaller.shared.getNewReleases { result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self.albums = model.albums.items
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    
    func getFeaturedPlaylists() {
        APICaller.shared.getFeaturedPlaylists { result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self.playlists = model.playlists.items
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    
    func getRecommendations() {
        APICaller.shared.getGenresSeeds { result in
            switch result {
            case .success(let model):
                let genres = model.genres
                var seeds = Set<String>()
                while seeds.count < 5 {
                    if let random = genres.randomElement() {
                        seeds.insert(random)
                    }
                }
                APICaller.shared.getRecommendations(genres: seeds) { result in
                    switch result {
                    case .success(let model):
                        DispatchQueue.main.async {
                            self.recomendations = model.tracks
                        }
                        break
                    case .failure(let error):
                        print(error)
                        break
                    }
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
}
