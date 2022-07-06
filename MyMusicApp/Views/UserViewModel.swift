//
//  UserViewModel.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 6/07/22.
//

import Foundation

class UserViewModel: ObservableObject {
    
    @Published var user: UserModel? = nil
    
    @Published var error = false
    
    @Published var playlists: [PlaylistsModel] = []
    
    @Published var albums: [AlbumItemModel] = []
    
    @Published var artists: [ArtistModel] = []
    
    func loadUserData() {
        APICaller.shared.getCurrentUserProfile { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.user = model
                    break
                case .failure(let error):
                    self.error = true
                    print(error.localizedDescription)
                    break
                }
            }
        }
    }
    
    func loadUserPlaylists() {
        APICaller.shared.getCurrentUserPlaylists() { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.playlists = model.items
                    break
                case .failure(let error):
                    self.error = true
                    print(error)
                    break
                }
            }
        }
    }
    
    func loadUserAlbums() {
        APICaller.shared.getCurrentUserAlbums() { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.albums = model.items
                    break
                case .failure(let error):
                    self.error = true
                    print(error)
                    break
                }
            }
        }
    }
    
    func loadUserFollowingArtists() {
        APICaller.shared.getCurrentUserFollowingArtists() { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    print(model)
                    self.artists = model.artists.items
                    break
                case .failure(let error):
                    self.error = true
                    print(error)
                    break
                }
            }
        }
    }
}

