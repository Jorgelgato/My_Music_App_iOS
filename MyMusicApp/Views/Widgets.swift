//
//  Widgets.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 21/06/22.
//

import Foundation
import SwiftUI
import CachedAsyncImage

struct ProfileImage: View {
    var url: String
    
    init(_ url: String) {
        self.url = url
    }
    
    var body: some View {
        AsyncImage(url: URL(string: url)){ phase in
            if let image = phase.image {
                image
                    .resizable()
            } else if phase.error != nil {
                Image("profile")
                    .colorMultiply(.primary)
                    .colorInvert()
            } else {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
        .background(.secondary)
        .clipShape(Circle())
    }
}

struct LoadImage: View {
    var url: String
    
    init(_ url: String) {
        self.url = url
    }
    
    var body: some View {
        CachedAsyncImage(url: URL(string: url)) { phase in
            if let image = phase.image {
                image
                    .resizable()
            } else if phase.error != nil {
                Image(systemName: "exclamationmark.triangle")
                    .colorMultiply(.primary)
                    .colorInvert()
            } else {
                ProgressView()
            }
        }
    }
}

