//
//  PlayerViewController.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 10/06/22.
//

import SwiftUI

struct PlayerViewController: View {
    @StateObject var playervm = PlayerViewVM.shared
    
    var body: some View {
        PlayerView()
    }
}

struct PlayerViewController_Previews: PreviewProvider {
    static var previews: some View {
        PlayerViewController()
    }
}
