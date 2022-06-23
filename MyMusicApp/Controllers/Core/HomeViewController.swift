//
//  HomeViewController.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 10/06/22.
//

import SwiftUI

struct HomeViewController: View {
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("")
                    .navigationBarTitle("Browse")
                    .toolbar {
                        Button {
                            showingSheet.toggle()
                        } label: {
                            Image(systemName: "gearshape")
                        }
                        .sheet(isPresented: $showingSheet) {
                            SettingsViewController(showingSheet: $showingSheet)
                        }
                    }
            }
        }
        .onAppear {
            APICaller.shared.getNewReleases { result in
                switch result {
                case .success(let model):
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }
            
            APICaller.shared.getFeaturedPlaylists { result in
                switch result {
                case .success(let model):
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }
            
            APICaller.shared.getGenresSeeds { result in
                switch result {
                case .success(let model):
                    let genres = model.genres
                    var seeds = Set<String>()
                    while seeds.count < 5 {
                        if let random = genres.randomElement() {
                            seeds.insert(random)
                        }
                    }
                    APICaller.shared.getRecommendations(genres: seeds) { result in
                        switch result {
                        case .success(let model):
                            break
                        case .failure(let error):
                            print(error)
                            break
                        }
                    }
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }
        }
    }
}

struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewController()
    }
}
