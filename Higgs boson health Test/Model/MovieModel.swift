//
//  MovieModel.swift
//  Higgs boson health Test
//
//  Created by Pratik Patil on 26/05/23.
//

import Foundation

//  Codable structure for parsing the data from JSON

struct MovieModel: Codable {
    let Title: String
    let Year: String
    let Rated: String
    let Released: String
    let Runtime: String
    let Genre: String
    let Director: String
    let Writer: String
    let Actors: String
    let Plot: String
    let Language: String
    let Country: String
    let Awards: String
    let Poster: String
    let Ratings: [Ratings]
    let Metascore: String
    let imdbRating: String
    let imdbVotes: String
    let imdbID: String
    let DVD: String
    let BoxOffice: String
    let Production: String
    let Website: String
    let Response: String
}

struct Ratings: Codable {
    let Source: String
    let Value: String
}

struct castStruct {
    let name: String?
    let movieName: String?
    let image: String?
}
