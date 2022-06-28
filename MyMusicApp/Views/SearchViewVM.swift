//
//  SearchViewVM.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 28/06/22.
//

import Foundation

class SearchViewVM: ObservableObject {
    
    @Published var categories: [CategoryModel] = []
    
    init() {
        getCategories()
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
    
    func search(search: String) -> String {
        return search
    }
    
}
