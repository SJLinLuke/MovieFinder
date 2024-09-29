//
//  Movie.swift
//  moviesAPP
//
//  Created by LukeLin on 2024/9/3.
//

import Foundation

struct MoviesResponse: Decodable {
    let page            : Int?
    let results         : [Movie]?
    let total_pages     : Int
    let total_results   : Int
}

struct Movie: Codable, Hashable {
    let adult               : Bool
    let backdrop_path       : String?
    let genre_ids           : [Int]
    let id                  : Int
    let original_language   : String
    let original_title      : String
    let overview            : String
    let popularity          : Double
    let poster_path         : String?
    let release_date        : String
    let title               : String
    let video               : Bool
    let vote_average        : Double
    let vote_count          : Int
}
