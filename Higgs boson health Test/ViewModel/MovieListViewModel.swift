//
//  MovieListViewModel.swift
//  Higgs boson health Test
//
//  Created by Pratik Patil on 31/05/23.
//

import Foundation

class MovieListViewModel {
    
    @Published var movies: [MovieModel] = []
//    Getting array count for movies
    func getNumberOfRowsInSection(section: Int) -> Int {
        return movies.count
    }
//    Getting a movie for cell
    func getMovieModel(row: Int) -> MovieModel {
        return movies[row]
    }
//    Parsing all movie records from JSON file.
    func parseMoviesRecords() {
        if let movies = FetchDataFromJSON.sharedInstance.readMovieData() {
            debugPrint(movies)
            self.movies = movies
        }
    }
}
