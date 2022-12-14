//
//  HapticsManager.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 10/06/22.
//

import Foundation
import SwiftUI

func artistsString(artists: [ArtistModel]) -> String {
    var string = ""
    for artist in artists {
        string.append(artist.name + ", ")
    }
    string.removeLast()
    string.removeLast()
    return string
}

func artistsString(artists: [PCMIObject]) -> String {
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

enum Size: CGFloat {
    case huge = 450
    case big = 240
    case medium = 200
    case small = 100
    case tiny = 70
}

enum ItemType: String {
    case artist = "Artist"
    case album = "Album"
    case playlist = "Playlist"
    case song = "Song"
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
