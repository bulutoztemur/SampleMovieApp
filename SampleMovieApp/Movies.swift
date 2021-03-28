//
//  Movies.swift
//  SampleMovieApp
//
//  Created by Alaattin Bulut Öztemur on 28.03.2021.
//

struct Movies: Codable {
    let search: [Movie]
    
    enum CodingKeys: String, CodingKey {
      case search = "Search"
    }

}
