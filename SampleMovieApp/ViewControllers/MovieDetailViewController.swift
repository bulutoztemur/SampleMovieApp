//
//  MovieDetailViewController.swift
//  SampleMovieApp
//
//  Created by Alaattin Bulut Öztemur on 28.03.2021.
//

import UIKit
import Alamofire

class MovieDetailViewController: UIViewController {

    private var imdbIDOfMovie: String?
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var imdbRatingLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    
    init(imdbID: String?) {
        self.imdbIDOfMovie = imdbID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.navigationBar.isHidden = true
    }
    
    func fetchData() {
        self.showIndicator()
        OmdbApiManager.shared.makeServiceCallForMovieDetail(parameters: self.createParameters()) { [weak self] (movieDetail) in
            if let posterPath = movieDetail.poster {
                if let posterURL = URL(string: posterPath) {
                    self?.moviePosterImageView.load(url: posterURL)
                }
            }
            self?.movieTitleLabel.text = movieDetail.title
            self?.plotLabel.text = movieDetail.plot
            if let rate = movieDetail.imdbRating {
                self?.imdbRatingLabel.text = Constants.IMDBRating + "\(rate)/10"
            } else {
                self?.imdbRatingLabel.text = "UNKNOWN"
            }
            self?.hideIndicator()
        }
    }
        
    func createParameters() -> Parameters {
        let parameters: Parameters = [
            "apikey": "83c5d643",
            "i" : self.imdbIDOfMovie ?? ""
        ]
        return parameters
    }

}
