//
//  Movie.swift
//  Flix
//
//  Created by Alina Abidi on 7/3/17.
//  Copyright © 2017 Claire Chen. All rights reserved.
//

import Foundation


class Movie {
    
    var title: String
    var posterURL: URL?
    var overview: String
    let baseURLString = "https://image.tmdb.org/t/p/w500"
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        overview = dictionary["overview"] as? String ?? "No overview"
        var posterPathString = dictionary["poster_path"] as! String
        posterURL = URL(string: baseURLString + posterPathString)!
    }
    
    class func movies(dictionaries: [[String:Any]]) -> [Movie]{
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        return movies
    }
 

}
