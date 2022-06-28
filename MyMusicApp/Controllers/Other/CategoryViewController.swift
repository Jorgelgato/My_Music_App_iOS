//
//  CategoryViewController.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 28/06/22.
//

import SwiftUI

struct CategoryViewController: View {
    var id: String
    @StateObject private var categoryViewVM: CategoryViewVM = CategoryViewVM()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.fixed(200)), GridItem(.fixed(200))]) {
                ForEach (categoryViewVM.playlists, id: \.self) { playlist in
                    NavigationLink(destination: PlaylistViewController(id: playlist.id)) {
                        PlaylistItem(playlist, size: .medium)
                    }
                }
            }
        }
        .onAppear {
            categoryViewVM.getCategory(id: id)
        }
    }
}

struct CategoryViewController_Previews: PreviewProvider {
    static var previews: some View {
        CategoryViewController(id: "")
    }
}
