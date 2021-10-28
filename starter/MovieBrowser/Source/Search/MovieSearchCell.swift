//
//  MovieSearchCell.swift
//  MovieBrowser
//
//  Created by manoj Singireddy on 10/26/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieSearchResultCell: UITableViewCell {

    var movie: Movie? {
        didSet {
            setUpCell()
        }
    }
    @IBOutlet weak var movieRatingsStackView: UIStackView!
    @IBOutlet weak var parentStackView: UIStackView!
    @IBOutlet weak var movieTitlesStackView: UIStackView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var releaseTitleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setUpCell() {
        
        if let movie = movie {
            title.text = movie.title
            let dateFormatter = ISO8601DateFormatter()
            dateFormatter.formatOptions = [.withYear,.withMonth,.withDay,.withDashSeparatorInDate]
            
            if let releaseDt = movie.releaseDate, let date = dateFormatter.date(from: releaseDt) {
                releaseTitleLabel.text = "Release Date : " + date.string(withFormat: "MM/dd/yy")
            } else {
                releaseTitleLabel.text = movie.releaseDate
            }
            ratingLabel.text = "\(movie.ratingScore)"
        }
    }
}


