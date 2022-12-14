//
//  SearchViewController.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 10/06/22.
//

import SwiftUI

struct SearchViewController: View {
    @StateObject private var searchViewVM: SearchViewVM = SearchViewVM()
    
    var body: some View {
        NavigationView {
            VStack {
                if searchViewVM.queryText.isEmpty {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.fixed(200)), GridItem(.fixed(200))]) {
                            ForEach(searchViewVM.categories, id: \.self) { category in
                                NavigationLink(destination: CategoryViewController(id: category.id)) {
                                    CategoryItem(category)
                                }
                            }
                        }
                    }
                } else {
                    SearchResultsViewController(search: searchViewVM.search)
                }
            }
            .padding(.horizontal, 10)
            .navigationBarTitle("Search")
            .searchable(text: $searchViewVM.searchText,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Artists, songs, or podcasts")
            .onChange(of: searchViewVM.queryText) { _ in
                searchViewVM.search(search: searchViewVM.queryText)
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct SearchViewController_Previews: PreviewProvider {
    static var previews: some View {
        SearchViewController()
    }
}
