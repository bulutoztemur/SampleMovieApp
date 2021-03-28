//
//  MovieCardCollectionViewCell.swift
//  SampleMovieApp
//
//  Created by Alaattin Bulut Öztemur on 28.03.2021.
//

import UIKit

class MovieCardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(movieData: Movie) {
        self.movieTitleLabel.text = movieData.title
        if let posterPath = movieData.poster {
            if let posterURL = URL(string: posterPath) {
                self.moviePoster.load(url: posterURL)
            }
        } else {
            self.moviePoster.image = UIImage(named: "noImage")
        }
        self.layer.cornerRadius = 5.0
    }
}
