//
//  PLayerViewVM.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 29/06/22.
//

import AVFoundation
import Foundation

class PlayerViewVM: ObservableObject {
    static let shared = PlayerViewVM()
    
    private init() {}
    
    @Published var track: TrackModel? = nil
    
    @Published var player: AVPlayer? = nil
    
    @Published var playing = false
    
    @Published var showing = false
    
    @Published var error = false
    
    func startPlayback(id: String) {
        APICaller.shared.getTrack(id: id) { result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    guard let url = URL(string: model.preview_url ?? "") else {
                        self.error = true
                        return
                    }
                    
                    self.track = model
                    
                    let item = AVPlayerItem(url: url)

                    NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: item)
                    
                    self.player = AVPlayer(playerItem: item)
                        
                    self.player?.play()
                    self.playing = true
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        self.playing = false
        self.player?.seek(to: .zero)
    }
    
    func togglePlayback() {
        if playing {
            player?.pause()
        } else {
            player?.play()
        }
        playing.toggle()
    }
    
}
