//
//  HapticsManager.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 10/06/22.
//

import Foundation

func artistsString(artists: [ArtistModel]) -> String {
    var string = ""
    for artist in artists {
        string.append(artist.name + ", ")
    }
    string.removeLast()
    string.removeLast()
    return string
}

func likesFormatter(likes: Int) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.usesGroupingSeparator = true
    return (formatter.string(from: NSNumber(value: likes)) ?? "0") + " likes"
}

func playlistDuration(items: [PlaylistItemModel]) -> String {
    var totalDuration = 0
    for item in items {
        totalDuration += item.track.duration_ms
    }
    let minutes = totalDuration/1000/60
    return "\(minutes/60)h \(minutes%60)min"
}

func trackDuration(duration: Int) -> String {
    let minutes = duration/1000
    return String(format: "%d:%02d", minutes/60, minutes%60)
}
