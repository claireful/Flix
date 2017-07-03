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
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        overview = dictionary["overview"] as? String ?? "No overview"
    }
 

}
