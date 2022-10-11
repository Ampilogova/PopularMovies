//
//  Movie.swift
//  Movies
//
//  Created by Tatiana Ampilogova on 6/4/22.
//

import Foundation

struct Movie: Codable {
    var title: String
    var overview: String
}

struct DataResult: Codable {
    var results: [Movie]
}
