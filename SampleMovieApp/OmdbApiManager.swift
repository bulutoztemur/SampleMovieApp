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
    
    func makeServiceCall(parameters: Parameters, process: @escaping ([Movie]) -> Void) {
        AF.request(OmdbApiManager.shared.url, parameters: parameters)
          .validate()
          .responseDecodable(of: Movies.self) { response in
            process(response.value?.search ?? [])
          }
    }
}
