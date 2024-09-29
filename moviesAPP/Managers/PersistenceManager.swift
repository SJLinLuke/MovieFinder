//
//  PersistenceManager.swift
//  moviesAPP
//
//  Created by LukeLin on 2024/9/7.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    static private let encoder  = JSONEncoder()
    static private let decoder  = JSONDecoder()
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func isFavorite(_ movie: Movie, complete: @escaping (Bool) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(let favoriteMovies):
                complete(favoriteMovies.contains(where: { $0.id == movie.id }))
                
            case .failure(let error):
                print(error.localizedDescription)
                complete(false)
            }
        }
    }
    
    static func updateFavorites(_ action: PersistenceActionType, with movie: Movie) {
        retrieveFavorites { result in
            switch result {
            case .success(var favoriteMovies):
                
                switch action {
                case .add:
                    guard !favoriteMovies.contains(where: { $0.id == movie.id }) else { return }
                    favoriteMovies.append(movie)
                    
                case .remove:
                    favoriteMovies.removeAll(where: { $0.id == movie.id })
                }
                
                saveFavorites(movies: favoriteMovies)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func retrieveFavorites(complete: @escaping (Result<[Movie], Error>) -> Void) {
        guard let encodedFavorites = defaults.data(forKey: Keys.favorites) else {
            complete(.success([]))
            return
        }
        
        do {
            let favoritesMovies = try decoder.decode([Movie].self, from: encodedFavorites)
            complete(.success(favoritesMovies))
        } catch {
            complete(.failure(error))
            print("Something went wrong retrieving favorites: \(error.localizedDescription)")
        }
    }
    
    
    static func saveFavorites(movies: [Movie]) {
        do {
            let encodedFavorites = try encoder.encode(movies)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
        } catch {
            print("Something went wrong saving favorites: \(error.localizedDescription)")
        }
    }
}
