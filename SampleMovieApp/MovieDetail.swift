//
//  MovieDetail.swift
//  SampleMovieApp
//
//  Created by Alaattin Bulut Öztemur on 28.03.2021.
//

struct MovieDetail: Codable {
    let title: String?
    let year: String?
    let rated: String?
    let imdbID: String?
    let plot: String?
    let imdbRating: String?
    let poster:String?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case imdbID
        case plot = "Plot"
        case imdbRating
        case poster = "Poster"
    }

}
