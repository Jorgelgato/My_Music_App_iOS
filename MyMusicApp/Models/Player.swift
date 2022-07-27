//
//  Player.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 25/07/22.
//

import Foundation

struct PlayerModel: Codable {
    let timestamp: Int
    let context: PContext
    let duration: Int
    let paused: Bool
    let shuffle: Bool
    let position: Int
    let loading: Bool
    let repeat_mode: Int
    let track_window: PTrackwindow
    let restrictions: PRestrictions
    let disallows: PDisallows
    let playback_id: String
    let playback_quality: String
    let playback_features: PPlaybackfeatures
}

struct PContext: Codable {
    let uri: String?
    let metadata: PCMetadata
}

struct PCMetadata: Codable {
    let name: String?
    let uri: String?
    let url: String?
    let current_item: PCMItem?
    let previous_items: [PCMItem]?
    let next_items: [PCMItem]?
    let options: PCMOptions?
    let restrictions: PCMRestrictions?
}

struct PCMItem: Codable {
    let name: String
    let uri: String
    let url: String
    let uid: String
    let content_type: String
    let artists: [PCMIObject]
    let images: [PCImages]
    let estimated_duration: Int
    let group: PCMIObject
    
}

struct PCMIObject: Codable {
    let name: String
    let uri: String
    let url: String
}

struct PCImages: Codable {
    let url: String
    let height: Int
    let width: Int
    let size: String
}

struct PCMOptions: Codable {
    let shuffled: Bool
    let repeat_mode: RepeatMode
}

enum RepeatMode: String, Codable {
    case OFF //0
    case CONTEXT //1
    case TRACK //2
}

struct PCMRestrictions: Codable {
    let pause: [String?]
    let resume: [String?]
    let seek: [String?]
    let skip_next: [String?]
    let skip_prev: [String?]
    let toggle_repeat_context: [String?]
    let toggle_repeat_track: [String?]
    let toggle_shuffle: [String?]
    let peek_next: [String?]
    let peek_prev: [String?]
}

struct PTrackwindow: Codable {
    let current_track: PTTrack?
    let next_tracks: [PTTrack]?
    let previous_tracks: [PTTrack]?
}

struct PTTrack: Codable {
    let id: String
    let uri: String
    let type: String
    let uid: String
    let linked_from: PTTLinkedfrom
    let media_type: String
    let track_type: String
    let name: String
    let duration_ms: Int
    let artists: [PCMIObject]
    let album: PTTAlbum
    let is_playable: Bool
}

struct PTTAlbum: Codable {
    let name: String
    let uri: String
    let images: [PCImages]
}

struct PTTLinkedfrom: Codable {
    let uri: String?
    let id: String?
}

struct PRestrictions: Codable {
    let disallow_seeking_reasons: [String]?
    let disallow_skipping_next_reasons: [String]?
    let disallow_skipping_prev_reasons: [String]?
    let disallow_toggling_repeat_context_reasons: [String]?
    let disallow_toggling_repeat_track_reasons: [String]?
    let disallow_toggling_shuffle_reasons: [String]?
    let disallow_peeking_next_reasons: [String]?
    let disallow_peeking_prev_reasons: [String]?
    let disallow_resuming_reasons: [String]?
    let disallow_pausing_reasons: [String]?
}

struct PDisallows: Codable {
    let seeking: Bool?
    let skipping_next: Bool?
    let skipping_prev: Bool?
    let toggling_repeat_context: Bool?
    let toggling_repeat_track: Bool?
    let toggling_shuffle: Bool?
    let peeking_next: Bool?
    let peeking_prev: Bool?
    let resuming: Bool?
    let pausing: Bool?
}

struct PPlaybackfeatures: Codable {
    let hifi_status: String
}
