//
//  MovieCell.swift
//  Flix
//
//  Created by Claire Chen on 6/21/17.
//  Copyright © 2017 Claire Chen. All rights reserved.
//

import UIKit
import SwipyCell
import Alamofire

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
            movie.title = titleLabel.text!
            movie.overview = overviewLabel.text!
            self.posterImage.image.af_setImage(withURL: movie.posterURL)
        
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
