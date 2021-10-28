//
//  Constants.swift
//  MovieBrowser
//
//  Created by manoj Singireddy on 10/27/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation


enum Constant {
    case MOVIE_search_URL(String)
    case Poster_Image_URL(String)
    
    static let BASE_URL = "https://api.themoviedb.org"
    static let API_KEY = "5885c445eab51c7004916b9c0313e2d3"
    static var IMAGE_URL = "https://image.tmdb.org"
    
    
    static func makeImagePath(url: String) -> String {
        return (Constant.IMAGE_URL + url)
    }
    
    //https://api.themoviedb.org/3/search/movie?api_key=5885c445eab51c7004916b9c0313e2d3&language=en-US&query=Spider&page=1&include_adult=false
    
    
    var path: String? {
        switch self {
        case .MOVIE_search_URL(let searchterm):
            if let text = searchterm.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
                return "\(Constant.BASE_URL)/3/search/movie?api_key=\(Constant.API_KEY)&query=\(text)"
            } else {
                return nil
            }
            
        case .Poster_Image_URL(let path):
            return Constant.IMAGE_URL + "/t/p/w500" + path
        }
    }
    
    struct Alert {
        static let title = "Alert"
        static let message = "Max year can not be less than minimum year"
        static let ok = "OK"
        static let cancel = "Cancel"
    }
    struct Parsing {
        static let message = "Json Parsing Error"
        static let unKnown = "UnKnown Error occur, please try again"
    }
    struct mDate {
        static let YYYYMMDD_Format = "YYYY-MM-DD"
    }
    
    struct Titles {
        static let naviagtionTitle = "Movie Search"
        static let placeholdertext = "Search movie"
    }
    
}



