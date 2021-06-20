//
//  Movie.swift
//
//  Created by Mahmoud Abdul-Wahab on 18/06/2021.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let isPlus18: Bool
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let vote: Double
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case isPlus18 = "adult"
        case title = "title"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case vote = "vote_average"
        case releaseDate = "release_date"
    }
}
