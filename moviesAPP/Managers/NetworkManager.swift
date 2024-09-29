//
//  NetworkManager.swift
//  moviesAPP
//
//  Created by LukeLin on 2024/9/3.
//

import UIKit

struct NetworkResponse<T: Decodable>: Decodable {
    let success: Bool
    let error_message: String?
    let data: [T]
}

class NetworkManager {
    static let shared = NetworkManager()
        
    let endPoint: String    = Constants.baseURL
    let decoder             = JSONDecoder()
    
    let imageCache = NSCache<NSString, UIImage>()
        
    func fetchGenres() async throws -> [GenresResponse.Genre] {
        let request = generateURLRequest(endPoint + "/genre/movie/list")
        let (data, _) = try await URLSession.shared.data(for: request)
        do {
            let response = try decoder.decode(GenresResponse.self, from: data)
            return response.genres
        } catch {
            throw error
        }
    }
    
    func fetchGenreMovies(by genreID: Int, page: Int, complete: @escaping (MoviesResponse) -> Void) {
        let request = generateURLRequest(endPoint + "/discover/movie?with_genres=\(genreID)&page=\(page)")
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
                print("data is null")
                return
            }
            
            do {
                let response = try self.decoder.decode(MoviesResponse.self, from: data)
                complete(response)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func fetchMoviesByName(by name: String, page: Int, complete: @escaping (MoviesResponse) -> Void) {
        let request = generateURLRequest(endPoint + "/search/movie?query=\(name)&page=\(page)")
//        let (data, _) = try await URLSession.shared.data(for: request)
//        do {
//            let response = try decoder.decode(MoviesResponse.self, from: data)
//            return response
//        } catch {
//            throw error
//        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
                print("data is null")
                return
            }
            
            do {
                let response = try self.decoder.decode(MoviesResponse.self, from: data)
                complete(response)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func fetchImage(with url: String) async throws -> UIImage? {
        guard let url = URL(string: url) else { return nil }
        
        let cacheKey: NSString = NSString(string: url.absoluteString)
        
        if let image = imageCache.object(forKey: cacheKey) { return image }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return nil }
            imageCache.setObject(UIImage(data: data)!, forKey: cacheKey)
            return UIImage(data: data)
        } catch {
            throw error
        }
    }
    
}

extension NetworkManager {
    
    func generateURLRequest(_ url: String) -> URLRequest {
        
        if let url = URL(string: url) {
            var request = URLRequest(url: url)
//            9ddc723b2bmsh852d4fe801a437fp149d86jsnf92195748a37 // bbc14160015@gmail.com
            
            request.setValue("f54d2f0162msh06e9a800cf75421p1651c6jsn19a5a80d52d3", forHTTPHeaderField: "x-rapidapi-key")
            return request
        }
        return URLRequest(url: URL(string: "")!)
    }
}
