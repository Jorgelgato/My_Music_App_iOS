//
//  APICaller.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 10/06/22.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    // MARK: Profile
    public func getCurrentUserProfile(completion: @escaping(Result<UserModel, Error>) -> Void) {
        createRequest(with: "/me", type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(UserModel.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }

    // MARK: Browse
    public func getNewReleases(completion: @escaping(Result<NewReleasesResponse, Error>) -> Void) {
        createRequest(with: "/browse/new-releases", type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getFeaturedPlaylists(completion: @escaping(Result<GeneralPlaylistsResponse, Error>) -> Void) {
        createRequest(with: "/browse/featured-playlists", type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(GeneralPlaylistsResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }

    public func getRecommendations(genres: Set<String>, completion: @escaping(Result<TracksResponse, Error>) -> Void) {
        let seeds = genres.joined(separator: ",")
        createRequest(with: "/recommendations?seed_genres=\(seeds)", type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(TracksResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getGenresSeeds(completion: @escaping(Result<GenresSeedsResponse, Error>) -> Void) {
        createRequest(with: "/recommendations/available-genre-seeds", type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(GenresSeedsResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: Album
    public func getAlbum(id: String, completion: @escaping(Result<AlbumModel, Error>) -> Void) {
        createRequest(with: "/albums/\(id)", type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(AlbumModel.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: Playlist
    public func getPlaylist(id: String, completion: @escaping(Result<PlaylistModel, Error>) -> Void) {
        createRequest(with: "/playlists/\(id)", type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(PlaylistModel.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: Categories
    public func getCategories(completion: @escaping(Result<CategoriesResponse, Error>) -> Void) {
        createRequest(with: "/browse/categories", type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(CategoriesResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getCategory(id: String, completion: @escaping(Result<GeneralPlaylistsResponse, Error>) -> Void) {
        createRequest(with: "/browse/categories/\(id)/playlists", type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(GeneralPlaylistsResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: Search
    public func search(with query: String, completion: @escaping(Result<SearchResponse, Error>) -> Void) {
        createRequest(with: "/search?type=artist,album,playlist,track&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")", type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(SearchResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getTrack(id: String, completion: @escaping(Result<TrackModel, Error>) -> Void) {
        createRequest(with: "/tracks/\(id)", type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(TrackModel.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: Library
    public func getCurrentUserPlaylists(completion: @escaping(Result<PlaylistsResponse, Error>) -> Void) {
        createRequest(with: "/me/playlists", type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(PlaylistsResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getCurrentUserAlbums(completion: @escaping(Result<AlbumsResponse, Error>) -> Void) {
        createRequest(with: "/me/albums", type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(AlbumsResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getCurrentUserFollowingArtists(completion: @escaping(Result<GeneralArtistsResponse, Error>) -> Void) {
        createRequest(with: "/me/following?type=artist", type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(GeneralArtistsResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: Artist
    public func getArtistTopTracks(id: String, completion: @escaping(Result<TracksResponse, Error>) -> Void) {
        createRequest(with: "/artists/\(id)/top-tracks?market=CO", type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(TracksResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }

    // MARK: Player
    public func getPlayer(completion: @escaping(Result<PlayerModel, Error>) -> Void) {
        createRequest(with: "/me/player", type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(PlayerModel.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func putStartPlayback(device: String, completion: @escaping(Result<Any, Error>) -> Void) {
        createRequest(with: "/me/player/play?device_id=\(device)", type: .PUT) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                completion(.success(data))
            }
            task.resume()
        }
    }
    
    public func putPausePlayback(device: String, completion: @escaping(Result<Any, Error>) -> Void) {
        createRequest(with: "/me/player/pause?device_id=\(device)", type: .PUT) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                completion(.success(data))
            }
            task.resume()
        }
    }
    
    public func putPlaySong(device: String, track: String, completion: @escaping(Result<Any, Error>) -> Void) {
        createRequest(with: "/me/player/play?device_id=\(device)", type: .PUT, body: ["uris":["spotify:track:\(track)"]]) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                completion(.success(data))
            }
            task.resume()
        }
    }
    
    public func postSkipNext(device: String, completion: @escaping(Result<Any, Error>) -> Void) {
        createRequest(with: "/me/player/next?device_id=\(device)", type: .POST) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                completion(.success(data))
            }
            task.resume()
        }
    }
    
    public func postSkipPrevious(device: String, completion: @escaping(Result<Any, Error>) -> Void) {
        createRequest(with: "/me/player/previous?device_id=\(device)", type: .POST) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                completion(.success(data))
            }
            task.resume()
        }
    }
    
    public func getSavedTracks(tracks: [String], completion: @escaping(Result<[Bool], Error>) -> Void) {
        let ids = tracks.joined(separator: ",")
        createRequest(with: "/me/tracks/contains?ids=\(ids)", type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode([Bool].self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func putSavedTracks(tracks: [String], completion: @escaping(Result<Any, Error>) -> Void) {
        let ids = tracks.joined(separator: ",")
        createRequest(with: "/me/tracks?ids=\(ids)", type: .PUT) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                completion(.success(data))
            }
            task.resume()
        }
    }
    
    public func deleteSavedTracks(tracks: [String], completion: @escaping(Result<Any, Error>) -> Void) {
        let ids = tracks.joined(separator: ",")
        createRequest(with: "/me/tracks?ids=\(ids)", type: .DELETE) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                completion(.success(data))
            }
            task.resume()
        }
    }
    
    
    enum HTTPMethod: String {
        case GET
        case POST
        case PUT
        case DELETE
    }
    
    private func createRequest(
        with url: String,
        type: HTTPMethod,
        completion: @escaping (URLRequest) -> Void
    ) {
        AuthManager.shared.withValidToken { token in
            var request = URLRequest(url: URL(string: Constants.baseAPIURL + url)!)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
    
    private func createRequest(
        with url: String,
        type: HTTPMethod,
        body: [String: Any] = ["": ""],
        completion: @escaping (URLRequest) -> Void
    ) {
        AuthManager.shared.withValidToken { token in
            var request = URLRequest(url: URL(string: Constants.baseAPIURL + url)!)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
            request.timeoutInterval = 30
            completion(request)
        }
    }
}
