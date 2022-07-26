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
    
    @Published var player: PlayerModel? = nil {
        didSet {
            if player != nil {
                self.progress = self.player!.position
                startProgress()
                checkSavedTrack(trackId: player!.track_window.current_track!.id)
            }
        }
    }
    
    @Published var showing = false
    
    @Published var progress = 0
    
    @Published var isSaved: Bool?
    
    var timer: Timer?
    
    func checkSavedTrack(trackId: String) {
        APICaller.shared.getSavedTracks(tracks: [trackId]) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.isSaved = model[0]
                    break
                case .failure(_):
                    break
                }
            }
        }
    }
    
    func saveTrack(trackId: String) {
        APICaller.shared.putSavedTracks(tracks: [trackId]) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.isSaved = true
                    break
                case .failure(_):
                    break
                }
            }
        }
    }
    
    func removeTrack(trackId: String) {
        APICaller.shared.deleteSavedTracks(tracks: [trackId]) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.isSaved = false
                    break
                case .failure(_):
                    break
                }
            }
        }
    }
    
    func startProgress() {
        timer?.invalidate()
        if !player!.paused {            
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                if self.progress + 1000 >= self.player!.duration || self.player!.paused {
                    timer.invalidate()
                }
                self.progress += 1000
            }
        }
    }
    
    func startPlayback() {
        APICaller.shared.putStartPlayback(device: AuthManager.shared.deviceID!) { result in
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
        APICaller.shared.putPausePlayback(device: AuthManager.shared.deviceID!) { result in
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
        APICaller.shared.putPlaySong(device: AuthManager.shared.deviceID!, track: trackId) { result in
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
    
    func skipNext() {
        APICaller.shared.postSkipNext(device: AuthManager.shared.deviceID!) { result in
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
    
    func skipPrevious() {
        APICaller.shared.postSkipPrevious(device: AuthManager.shared.deviceID!) { result in
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
