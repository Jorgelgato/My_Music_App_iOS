//
//  ArtistView.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 29/06/22.
//

import Foundation
import SwiftUI

struct ArtistView: View {
    let artist: ArtistModel
    
    init(_ artist: ArtistModel) {
        self.artist = artist
    }
    
    var body: some View {
        VStack {
            LoadImage(artist.images?[0].url ?? "error")
                .frame(width: Size.huge.rawValue, height: Size.huge.rawValue)
            Spacer()
        }
    }
}
