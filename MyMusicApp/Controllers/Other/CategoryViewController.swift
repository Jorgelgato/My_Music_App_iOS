//
//  CategoryViewController.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 28/06/22.
//

import SwiftUI

struct CategoryViewController: View {
    var id: String
    
    var body: some View {
        Text(id)
    }
}

struct CategoryViewController_Previews: PreviewProvider {
    static var previews: some View {
        CategoryViewController(id: "")
    }
}
