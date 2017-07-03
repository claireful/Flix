//
//  MovieCell.swift
//  Flix
//
//  Created by Claire Chen on 6/21/17.
//  Copyright © 2017 Claire Chen. All rights reserved.
//

import UIKit
import SwipyCell
import AlamofireImage

class MovieCell: UITableViewCell {
    //Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    
    //Add property observers (willSet and didSet) to the movie property
    var movie: Movie! {
        willSet {
            print("Will set the movie")
        }
        didSet {
            print("Did set movie")
            titleLabel.text! =  movie.title
            overviewLabel.text! = movie.overview
            
            if let validURL = movie.posterURL {
                self.posterImage.af_setImage(withURL: validURL)

            }
            
        }
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
