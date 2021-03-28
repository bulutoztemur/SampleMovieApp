//
//  OmdbApiManager.swift
//  SampleMovieApp
//
//  Created by Alaattin Bulut Öztemur on 28.03.2021.
//

import Foundation
import Alamofire

class OmdbApiManager {
    public static let shared = OmdbApiManager()
    private init() {}
    var pageID = 1 
    private let url = "https://www.omdbapi.com/"
    
    func makeServiceCallForMovies(parameters: Parameters, process: @escaping ([Movie]) -> Void) {
        AF.request(OmdbApiManager.shared.url, parameters: parameters)
          .validate()
          .responseDecodable(of: Movies.self) { response in
            process(response.value?.search ?? [])
          }
    }
    
    func makeServiceCallForMovieDetail(parameters: Parameters, process: @escaping (MovieDetail) -> Void) {
        AF.request(OmdbApiManager.shared.url, parameters: parameters)
          .validate()
          .responseDecodable(of: MovieDetail.self) { response in
            guard let response = response.value else { return }
            process(response)
          }
    }

    
}
