//
//  MainViewController.swift
//  SampleMovieApp
//
//  Created by Alaattin Bulut Öztemur on 28.03.2021.
//

import UIKit
import Alamofire

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var fetchedMovieList: [Movie] = []
    
    var isWaiting: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.handleDelegationAndRegister()
        self.setSearchBarInitValue()
        self.fetchData()
    }
    
    func setSearchBarInitValue() {
        self.searchBar.text = Constants.InitialSampleSearchKey
        self.searchBar.placeholder = Constants.SearchBarPlaceholder
    }
    
    func handleDelegationAndRegister() {
        self.searchBar.delegate = self
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "MovieCardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
    }
    
    func fetchData() {
        OmdbApiManager.shared.makeServiceCall(parameters: self.createParameters()) { [weak self] (movieList) in
            self?.fetchedMovieList += movieList
            OmdbApiManager.shared.pageID += 1
            self?.collectionView.reloadData()
            if(movieList.count != 0) {
                self?.isWaiting = false
            }
        }
    }
        
    func createParameters() -> Parameters {
        let parameters: Parameters = [
            "apikey": "83c5d643",
            "page" : OmdbApiManager.shared.pageID,
            "s" : self.getSearchBarText(),
            "type" : "movie"
        ]
        return parameters
    }
    
    func getSearchBarText() -> String {
        guard let searchBarText = searchBar.text else { return "" }
        let searchText = searchBarText.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "_")
        return searchText + Constants.WildcardCharacter
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.fetchedMovieList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if(fetchedMovieList.count == 0) {
            self.collectionView.backgroundView = self.createNoDataView()
            return 0
        } else {
            self.collectionView.backgroundView = nil
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCardCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? MovieCardCollectionViewCell)?.configureCell(movieData: self.fetchedMovieList[indexPath.row])
        
        if indexPath.row == self.collectionView.numberOfItems(inSection: 0) - 3 && !isWaiting {
           isWaiting = true
           self.doPaging()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidthRate: CGFloat = 6
        let cellWidth = cellWidthRate * (Constants.ScreenWidth - 30) / 12
        let cellHeight = cellWidth * 1.5
        return CGSize(width: cellWidth, height: cellHeight)
    }

    private func doPaging() {
        self.fetchData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        OmdbApiManager.shared.pageID = 1
        self.fetchedMovieList = []
        if searchText != "" {
            self.fetchData()
        } else {
            self.collectionView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    func createNoDataView() -> UILabel {
        let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.collectionView.bounds.size.width, height: self.collectionView.bounds.size.height))
        noDataLabel.text = "No Data Available"
        noDataLabel.textColor = UIColor(red: 22.0/255.0, green: 106.0/255.0, blue: 176.0/255.0, alpha: 1.0)
        noDataLabel.textAlignment = NSTextAlignment.center
        return noDataLabel
    }
}
