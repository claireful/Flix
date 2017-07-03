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
        
        KRProgressHUD.show()
        //create network request
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        //force unwrap ^^ nil would crash. only case where this would be nil is when apikey is wrong-->crash intended
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            //this will run with the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let movieDictionaries = dataDictionary["results"] as! [[String:Any]] //an array of dictionaries
                self.movies = Movie.movies(dictionaries: movieDictionaries)
//                self.movies = []
//                for dictionary in movieDictionaries {
//                    let movie = Movie(dictionary:dictionary)
//                    self.movies.append(movie)
                }
                
                //wait for netword request to return to set up tableview -- bc asyncronous
                self.tableView.reloadData()
                KRProgressHUD.dismiss()
                //got all the data

                /*
                 for movie in movies{
                 let title = movie["title"] as! String
                 print(title)
                 }
                 */
                
                self.refreshControl.endRefreshing()
            }  //^^completion block
            
        
        task.resume()
        
        
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
    
    
    
    

