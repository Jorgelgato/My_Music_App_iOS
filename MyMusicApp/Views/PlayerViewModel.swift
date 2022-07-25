//
//  PlayerViewModel.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 22/07/22.
//

import Foundation

class PlayerViewModel: ObservableObject {
    
    static let shared = PlayerViewModel()
    
    private init() {}
    
    @Published var player: PlayerModel? = nil
    
    @Published var showing = false
    
    func startPlayback() {
        APICaller.shared.putStartPlayback(device: AuthManager.shared.deviceID ?? "") { result in
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
    
    func pausePlayback() {
        APICaller.shared.putPausePlayback(device: AuthManager.shared.deviceID ?? "") { result in
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

    func startPlayback(trackId: String) {
        APICaller.shared.putPlaySong(device: AuthManager.shared.deviceID ?? "", track: trackId) { result in
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
