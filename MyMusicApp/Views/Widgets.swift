//
//  Widgets.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 21/06/22.
//

import Foundation
import SwiftUI

struct ProfileImage: View {
    var url: String
    
    init(_ url: String){
        self.url = url
    }
    
    var body: some View{
        AsyncImage(url: URL(string: url)){ phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
            case .failure:
                Image("profile")
                    .resizable()
            @unknown default:
                Image("profile")
                    .resizable()
            }
        }
        .frame(width: 200, height: 200)
        .clipShape(Circle())
    }
}
