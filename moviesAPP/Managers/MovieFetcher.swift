//
//  MovieFetcher.swift
//  moviesAPP
//
//  Created by LukeLin on 2024/9/5.
//

import Foundation

class MovieFetcher {
    static var shared = MovieFetcher()
    
    var fetchGeneraQueue: [(genre: Int, complete: (MoviesResponse) -> Void)] = []
    var isFetching: Bool = false
    
    func addFetchGeneraTask(_ genre: Int, complete: @escaping (MoviesResponse) -> Void) {
        fetchGeneraQueue.append((genre, complete))
        
        if !isFetching { startFetchGenraMovies() }
    }
    
    private func startFetchGenraMovies() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            guard !self.isFetching, !self.fetchGeneraQueue.isEmpty else { return }
            
            self.isFetching = true
            let currentTask = self.fetchGeneraQueue.removeFirst()
            
            NetworkManager.shared.fetchGenreMovies(by: currentTask.genre, page: 1) {[weak self] response in
                guard let self else { return }
                
                currentTask.complete(response)
                
                self.isFetching = false
                self.startFetchGenraMovies()
            }
        }
    }
}
