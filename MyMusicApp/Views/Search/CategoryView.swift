//
//  CategoryView.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 28/06/22.
//

import Foundation
import SwiftUI

struct CategoryItem: View {
    let category: CategoryModel
    
    init(_ category: CategoryModel) {
        self.category = category
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color("Background"))
            HStack {
                VStack {
                    Text(category.name)
                        .font(.body.bold())
                        .padding()
                        .clipped()
                    Spacer()
                }
                Spacer()
                VStack {
                    Spacer()
                    LoadImage(category.icons[0].url)
                        .frame(width: 80, height: 80)
                        .rotationEffect(.degrees(25))
                        .offset(x: 20)
                }
            }
            
        }
        .frame(width: 200, height: 110)
        .clipped()
    }
}

