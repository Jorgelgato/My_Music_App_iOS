//
//  SearchViewController.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 10/06/22.
//

import SwiftUI

struct SearchViewController: View {
    @StateObject private var searchViewVM: SearchViewVM = SearchViewVM()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.fixed(200)), GridItem(.fixed(200))]) {
                    ForEach(searchViewVM.categories, id: \.self) { category in
                        NavigationLink(destination: CategoryViewController(id: category.id)) {
                            CateoryItem(category)
                        }
                    }
                }
            }
            .padding()
            .navigationBarTitle("Search")
            .searchable(text: $searchText,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Artists, songs, or podcasts")
        }
    }
}

struct SearchViewController_Previews: PreviewProvider {
    static var previews: some View {
        SearchViewController()
    }
}
