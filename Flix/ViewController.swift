//
//  ViewController.swift
//  Flix
//
//  Created by Saul Fernandez on 1/8/21.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        let movie = moviesArray[indexPath.row]
        cell.title.text = movie["title"] as? String ?? ""
        cell.desc.text = movie["overview"] as? String ?? ""
//        if let ImageUrlString = movie["image_url"] as? String{let imageUrl = URL(string: ImageUrlString)
//            cell.movieImage.af.setImage(withURL: imageUrl!)
        
        
//        }
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: baseURL+posterPath)
        print(posterURL)
        cell.movieImage.af.setImage(withURL: posterURL!)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }
    
    
    
    // ––––– TODO: Add storyboard Items (i.e. tableView + Cell + configurations for Cell + cell outlets)
    // ––––– TODO: Next, place TableView outlet here
    @IBOutlet weak var tableView: UITableView!
    
    
    // –––––– TODO: Initialize moviesArray
    
    var moviesArray: [[String:Any?]] = []
    
    // ––––– TODO: Add tableView datasource + delegate
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getAPIData()

    }
    
    
    // ––––– TODO: Get data from API helper and retrieve movies
    func getAPIData(){
        API.getMovies(){
            (movies) in guard let movies = movies else {return}
            print(movies)
            self.moviesArray = movies
            self.tableView.reloadData()
        }
    }


}

