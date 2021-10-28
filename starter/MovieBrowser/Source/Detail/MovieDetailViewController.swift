//
//  MovieDetailViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/26/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movie: Movie?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        
        if let movie = self.movie {
            titleLabel.text = movie.title
            let dateFormatter = ISO8601DateFormatter()
            dateFormatter.formatOptions = [.withYear,.withMonth,.withDay,.withDashSeparatorInDate]
            
            if let releaseDt = movie.releaseDate, let date = dateFormatter.date(from: releaseDt) {
                releaseDateLabel.text = "Release Date : " + date.string(withFormat: "MM/dd/yy")
            } else {
                releaseDateLabel.text = movie.releaseDate
            }
            overviewLabel.text = movie.description
            if let path = movie.imagePath {
                loadImage(path: path)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func loadImage(path: String) {
        getImageFor(path: path) { Data in
            if let image = UIImage.init(data: Data) {
                DispatchQueue.main.async {
                    //self.posterImage.image = UIImage.init(data: Data)
                    self.configure(image: image)
                }
            }
        }
    }
    
    
    func configure(image:UIImage) {
        self.posterImage.image = image
        self.posterImage.layoutIfNeeded()
    }
    
    
    func getImageFor(path: String, completion: @escaping (Data) -> Void) {
        
        let api = MovieAPI()
        if let url = Constant.Poster_Image_URL(path).path {
            api.getDataFromServer(url: url, type: RequestType.posterImage) { data, Error in
                if let data = data as? Data {
                    completion(data)
                }
            }
        }
    }
    
}
