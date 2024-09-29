//
//  Generas.swift
//  moviesAPP
//
//  Created by LukeLin on 2024/9/3.
//

import Foundation

struct GenresResponse: Decodable {
    let genres: [Genre]
    
    struct Genre: Decodable {
        let id  : Int
        let name: String
    }
}
