//
//  Movie.swift
//  MovieBrowser
//
//  Created by manoj Singireddy on 10/26/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

struct MovieContainer: Codable {
    var page: Int
    var total_results: Int
    var total_pages: Int
    var results: [Movie]
}

struct Movie: Codable {
    
    let title: String
    let imagePath: String?
    let releaseDate: String?
    let ratingScore: Double
    let description: String
    let secondaryImage: String?
    let genreIDs: [Int]
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case imagePath = "poster_path"
        case secondaryImage = "backdrop_path"
        case releaseDate = "release_date"
        case ratingScore = "vote_average"
        case description = "overview"
        case genreIDs = "genre_ids"
    }

}

