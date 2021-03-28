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
        if let posterUrl = movieData.poster {
            self.moviePoster.load(url: URL(string: posterUrl)!)
        } else {
            self.moviePoster.image = nil
        }
        self.layer.cornerRadius = 5.0
    }
}
