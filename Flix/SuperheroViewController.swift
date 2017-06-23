//
//  SuperheroViewController.swift
//  Flix
//
//  Created by Claire Chen on 6/23/17.
//  Copyright © 2017 Claire Chen. All rights reserved.
//

import UIKit
import KRProgressHUD


class SuperheroViewController: UIViewController, UICollectionViewDataSource {
    
    var movies: [[String: Any]] = []
    //Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        fetchNMovies()
        
        // Do any additional setup after loading the view.
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        let movie = movies[indexPath.item]
        if let posterPathString = movie["poster_path"] as? String{
            let baseURLString:String = "https://image.tmdb.org/t/p/w500"
            let posterURL = URL(string: baseURLString + posterPathString)!
            cell.posterImageView.af_setImage(withURL: posterURL)
            
            
        }
        return cell
        
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
                
                let movies = dataDictionary["results"] as! [[String:Any]] //an array of dictionaries
                self.movies = movies
                
                //wait for netword request to return to set up tableview -- bc asyncronous
                self.collectionView.reloadData()
                KRProgressHUD.dismiss()
                //got all the data
                
                /*
                 for movie in movies{
                 let title = movie["title"] as! String
                 print(title)
                 }
                 */
                
                //self.refreshControl.endRefreshing()
            }  //^^completion block
            
        }
        task.resume()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
