//
//  MovieDetailsViewModel.swift
//  Higgs boson health Test
//
//  Created by Pratik Patil on 31/05/23.
//

import Foundation

class MovieDetailsViewModel {
    @Published var title = ""
    @Published var finalTimeValue = ""
    @Published var genres: [String] = []
    @Published var plot = ""
    @Published var movieRating = NSAttributedString()
    @Published var imdbVotes = ""
    @Published var metascore = ""
    @Published var cast: [castStruct] = []
    @Published var director = ""
    @Published var writer = ""
    @Published var awards = ""
    @Published var reviewDate = ""
    @Published var userReviewRating = NSAttributedString()
    
    var movie: MovieModel!
    
    init(movie: MovieModel) {
        self.movie = movie
        prepareFinalTime()
        prepareOtherValues()
    }
//    Preparing final time from runtime in minutes
    func prepareFinalTime() {
        if let stringTime = movie.runtime {
            let splittedItems = stringTime.split(separator: " ")
            
            if let runtimeInMinutes = Int(splittedItems[0]) {
                let convertedTime = runtimeInMinutes.minutesToHHMM()
                let finalTime = "\(convertedTime.hours)" + "h " + "\(convertedTime.leftMinutes)" + "m"
                if let year = movie.year {
                    if let rated = movie.rated {
                        finalTimeValue = year + "  " + rated + "  " + finalTime
                    }
                }
            }
        }
    }
//    Preparing all other values for population
    func prepareOtherValues() {
        title = movie.title ?? ""
        plot = movie.plot ?? ""
        imdbVotes = movie.imdbVotes ?? ""
        metascore = "\(movie.metascore ?? "") critic reviews"
        director = movie.director ?? ""
        writer = movie.writer ?? ""
        awards = movie.awards ?? ""
        reviewDate = movie.dVD ?? ""
    }
//    Getting Poster image URL
    func getPosterImageURLString() -> URL? {
        return URL(string: movie.poster ?? "")
    }
//    Getting Cast List
    func getCast() {
        if let actors = movie.actors {
            let splittedActors = actors.split(separator: ",")
            cast.append(castStruct(name: "\(splittedActors[0])", movieName: "Neo", image: "image 1.jpg"))
            cast.append(castStruct(name: "\(splittedActors[1])", movieName: "Morpheus", image: "image 2.jpg"))
            cast.append(castStruct(name: "\(splittedActors[2])", movieName: "Trinity", image: "image 3.jpg"))
        }
    }
//    Getting Genre List
    func getGenreList() {
        if let genre = movie.genre {
            let filteredString = genre.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
            let arr = filteredString.split(separator: " ")
            for i in arr {
                genres.append("\(i)")
            }
        }
    }
//    Getting IMDB Rating
    func getImdbRating() -> String {
        return movie.imdbRating ?? ""
    }
//    Getting Genre
    func getGenre(row: Int) -> String {
        return genres[row]
    }
//    Getting array count for Genre
    func getNumberOfGenreInSection(section: Int) -> Int {
        return genres.count
    }
//    Getting single cast member for cell
    func getCastMember(row: Int) -> castStruct {
        return cast[row]
    }
//    Getting array count for cast
    func getNumberOfCastInSection(section: Int) -> Int {
        return cast.count
    }
}
