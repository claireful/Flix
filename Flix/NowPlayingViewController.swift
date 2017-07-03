//
//  NowPlayingViewController.swift
//  Flix
//
//  Created by Claire Chen on 6/21/17.
//  Copyright © 2017 Claire Chen. All rights reserved.
//

import UIKit
import AlamofireImage
import KRProgressHUD
import SwipyCell

class NowPlayingViewController: UIViewController, UITableViewDataSource {
    
    //Variables & Outlets
    @IBOutlet weak var tableView: UITableView!
    var movies: [Movie] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        //handle being datasource
        tableView.dataSource = self
        
        //row
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        
        fetchNMovies()
        
        
        
    }
    
    func didPullToRefresh(_ refreshControl:UIRefreshControl){
        fetchNMovies()
    }
    
    func fetchNMovies(){
        
        //KRProgressHUD.show()
        //create network request
        MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.tableView.reloadData()
            }
        }        
        
    }
    
    //data source methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        
        //let movie = movies[indexPath.row]
        cell.movie = movies[indexPath.row]

//        let title = movie.title //movie["title"] as! String
//        let overview = movie.overview //movie["overview"] as! String
//        
//        cell.titleLabel.text = title
//        cell.overviewLabel.text = overview
//        
//        let posterPath = movie.posterURL //movie["poster_path"] as! String
//        //let baseURLString = "https://image.tmdb.org/t/p/w500"
//        //let posterURL = URL(string: baseURLString + posterPathString)!
//        
//        cell.posterImage.af_setImage(withURL: posterPath!)
//        //cell.delegate = self
        
        
        
        //drag
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.singleMovie = movie
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
    
    
    
    

