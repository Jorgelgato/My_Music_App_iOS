//
//  SearchViewVM.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 28/06/22.
//

import Foundation

class SearchViewVM: ObservableObject {
    
    @Published var categories: [CategoryModel] = []
    @Published var search: SearchResponse? = nil
    @Published var searchText = ""
    @Published var queryText = ""
    
    init() {
        getCategories()
        $searchText
            .debounce(for: 0.7, scheduler: DispatchQueue.main)
            .assign(to: &$queryText)
    }
    
    func getCategories() {
        APICaller.shared.getCategories { result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self.categories = model.categories.items
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func search(search: String) {
        APICaller.shared.search(with: search) { result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self.search = model
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
}
