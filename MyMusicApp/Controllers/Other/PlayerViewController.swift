//
//  PlayerViewController.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 10/06/22.
//

import SwiftUI

struct PlayerViewController: View {
    var body: some View {
        VStack {
            HStack {
                Button {
                    PlayerViewVM.shared.showing.toggle()
                } label: {
                    Image(systemName: "chevron.down")
                }
                Spacer()
                Text("")
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "ellipsis")
                        .rotationEffect(.degrees(90))
                }
            }
            .padding(40)
            Spacer()
            PlayerView()
        }
    }
}

struct PlayerViewController_Previews: PreviewProvider {
    static var previews: some View {
        PlayerViewController()
    }
}
