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
        createRequest(url: "/me", method: .GET, type: UserModel.self) { result in
            completion(result)
        }
    }
    
    // MARK: Browse
    public func getNewReleases(completion: @escaping(Result<NewReleasesResponse, Error>) -> Void) {
        createRequest(url: "/browse/new-releases", method: .GET, type: NewReleasesResponse.self) { result in
            completion(result)
        }
    }
    
    public func getFeaturedPlaylists(completion: @escaping(Result<GeneralPlaylistsResponse, Error>) -> Void) {
        createRequest(url: "/browse/featured-playlists", method: .GET, type: GeneralPlaylistsResponse.self) { result in
            completion(result)
        }
    }
    
    public func getRecommendations(genres: Set<String>, completion: @escaping(Result<TracksResponse, Error>) -> Void) {
        let seeds = genres.joined(separator: ",")
        createRequest(url: "/recommendations?seed_genres=\(seeds)", method: .GET, type: TracksResponse.self) { result in
            completion(result)
        }
    }
    
    public func getGenresSeeds(completion: @escaping(Result<GenresSeedsResponse, Error>) -> Void) {
        createRequest(url: "/recommendations/available-genre-seeds", method: .GET, type: GenresSeedsResponse.self) { result in
            completion(result)
        }
    }
    
    // MARK: Album
    public func getAlbum(id: String, completion: @escaping(Result<AlbumModel, Error>) -> Void) {
        createRequest(url: "/albums/\(id)", method: .GET, type: AlbumModel.self) { result in
            completion(result)
        }
    }
    
    // MARK: Playlist
    public func getPlaylist(id: String, completion: @escaping(Result<PlaylistModel, Error>) -> Void) {
        createRequest(url: "/playlists/\(id)", method: .GET, type: PlaylistModel.self) { result in
            completion(result)
        }
    }
    
    // MARK: Categories
    public func getCategories(completion: @escaping(Result<CategoriesResponse, Error>) -> Void) {
        createRequest(url: "/browse/categories", method: .GET, type: CategoriesResponse.self) { result in
            completion(result)
        }
    }
    
    public func getCategory(id: String, completion: @escaping(Result<GeneralPlaylistsResponse, Error>) -> Void) {
        createRequest(url: "/browse/categories/\(id)/playlists", method: .GET, type: GeneralPlaylistsResponse.self) { result in
            completion(result)
        }
    }
    
    // MARK: Search
    public func search(with query: String, completion: @escaping(Result<SearchResponse, Error>) -> Void) {
        createRequest(url: "/search?type=artist,album,playlist,track&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")", method: .GET, type: SearchResponse.self) { result in
            completion(result)
        }
    }
    
    public func getTrack(id: String, completion: @escaping(Result<TrackModel, Error>) -> Void) {
        createRequest(url: "/tracks/\(id)", method: .GET, type: TrackModel.self) { result in
            completion(result)
        }
    }
    
    // MARK: Library
    public func getCurrentUserPlaylists(completion: @escaping(Result<PlaylistsResponse, Error>) -> Void) {
        createRequest(url: "/me/playlists", method: .GET, type: PlaylistsResponse.self) { result in
            completion(result)
        }
    }
    
    public func getCurrentUserAlbums(completion: @escaping(Result<AlbumsResponse, Error>) -> Void) {
        createRequest(url: "/me/albums", method: .GET, type: AlbumsResponse.self) { result in
            completion(result)
        }
    }
    
    public func getCurrentUserFollowingArtists(completion: @escaping(Result<GeneralArtistsResponse, Error>) -> Void) {
        createRequest(url: "/me/following?type=artist", method: .GET, type: GeneralArtistsResponse.self) { result in
            completion(result)
        }
    }
    
    // MARK: Artist
    public func getArtistTopTracks(id: String, completion: @escaping(Result<TracksResponse, Error>) -> Void) {
        createRequest(url: "/artists/\(id)/top-tracks?market=CO", method: .GET, type: TracksResponse.self) { result in
            completion(result)
        }
    }
    

    public func getArtist(id: String, completion: @escaping(Result<ArtistModel, Error>) -> Void) {
        createRequest(url: "/artists/\(id)", method: .GET, type: ArtistModel.self) { result in
            completion(result)
        }
    }
    
    // MARK: Player
    public func getPlayer(completion: @escaping(Result<PlayerModel, Error>) -> Void) {
        createRequest(url: "/me/player", method: .GET, type: PlayerModel.self) { result in
            completion(result)
        }
    }
    
    public func putStartPlayback(device: String, completion: @escaping(Result<String, Error>) -> Void) {
        createRequest(url: "/me/player/play?device_id=\(device)", method: .PUT, type: String.self) { result in
            completion(result)
        }
    }
    
    public func putPausePlayback(device: String, completion: @escaping(Result<String, Error>) -> Void) {
        createRequest(url: "/me/player/pause?device_id=\(device)", method: .PUT, type: String.self) { result in
            completion(result)
        }
    }
    
    public func putPlayUris(device: String, context: [String], completion: @escaping(Result<Data, Error>) -> Void) {
        createRequest(url: "/me/player/play?device_id=\(device)", method: .PUT, body: ["uris":context]) { result in
            completion(result)
        }
    }
    
    public func putPlayContextUri(device: String, context: String, completion: @escaping(Result<Data, Error>) -> Void) {
        createRequest(url: "/me/player/play?device_id=\(device)", method: .PUT, body: ["context_uri":context]) { result in
            completion(result)
        }
    }
    
    public func postSkipNext(device: String, completion: @escaping(Result<Data, Error>) -> Void) {
        createRequest(url: "/me/player/next?device_id=\(device)", method: .POST) { result in
            completion(result)
        }
    }
    
    public func postSkipPrevious(device: String, completion: @escaping(Result<Data, Error>) -> Void) {
        createRequest(url: "/me/player/previous?device_id=\(device)", method: .POST) { result in
            completion(result)
        }
    }
    
    public func getSavedTracks(tracks: [String], completion: @escaping(Result<[Bool], Error>) -> Void) {
        let ids = tracks.joined(separator: ",")
        createRequest(url: "/me/tracks/contains?ids=\(ids)", method: .GET, type: [Bool].self) { result in
            completion(result)
        }
    }
    
    public func putSavedTracks(tracks: [String], completion: @escaping(Result<Data, Error>) -> Void) {
        let ids = tracks.joined(separator: ",")
        createRequest(url: "/me/tracks?ids=\(ids)", method: .PUT) { result in
            completion(result)
        }
    }
    
    public func deleteSavedTracks(tracks: [String], completion: @escaping(Result<Data, Error>) -> Void) {
        let ids = tracks.joined(separator: ",")
        createRequest(url: "/me/tracks?ids=\(ids)", method: .PUT) { result in
            completion(result)
        }
    }
    
    public func putToggleShuffle(state: Bool, completion: @escaping(Result<Data, Error>) -> Void) {
        createRequest(url: "/me/player/shuffle?state=\(state)", method: .PUT) { result in
            completion(result)
        }
    }
    
    public func putRepeatMode(state: RepeatMode, completion: @escaping(Result<Data, Error>) -> Void) {
        createRequest(url: "/me/player/repeat?state=\(state.rawValue.lowercased())", method: .PUT) { result in
            completion(result)
        }
    }
    
    enum HTTPMethod: String {
        case GET
        case POST
        case PUT
        case DELETE
    }
    
    private func createRequest<T: Codable>(url: String, method: HTTPMethod, body: [String: [String]] = [:], type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        sendRequest(with: url, type: method, body: body) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    print(String(decoding: data, as: UTF8.self))
                    let result = try JSONDecoder().decode(type.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    private func createRequest(url: String, method: HTTPMethod, body: [String: Any] = [:], completion: @escaping (Result<Data, Error>) -> Void) {
        print(body)
        sendRequest(with: url, type: method, body: body) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                print(String(decoding: data, as: UTF8.self))
                completion(.success(data))
            }
            task.resume()
        }
    }
    
    private func sendRequest(
        with url: String,
        type: HTTPMethod,
        body: [String: Any],
        completion: @escaping (URLRequest) -> Void
    ) {
        AuthManager.shared.withValidToken { token in
            var request = URLRequest(url: URL(string: Constants.baseAPIURL + url)!)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            if !body.isEmpty {
                request.httpBody = try? JSONSerialization.data(withJSONObject: body)
            }
            request.timeoutInterval = 30
            print(request)
            completion(request)
        }
    }
}
