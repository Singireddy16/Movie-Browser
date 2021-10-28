//
//  Network.swift
//  SampleApp
//
//  Created by Struzinski, Mark - Mark on 9/17/20.
//  Copyright © 2020 Lowe's Home Improvement. All rights reserved.
//

import UIKit

protocol Request {
    func getURLRequest(url: String) -> URLRequest?
}

enum RequestType: Request {
    case MovieList
    case posterImage
    
    init(type: RequestType) {
        self = type
    }
    
    func getURLRequest(url: String) -> URLRequest? {
        
        switch self {
        case .MovieList:
            guard let url = URL(string: url) else {return nil }
            return URLRequest(url: url)
        case .posterImage:
            guard let url = URL(string: url) else {return nil }
            return URLRequest(url: url)
        }
    }
}

class Network {
    let apiKey = "5885c445eab51c7004916b9c0313e2d3"
}

enum NetworkError: Error {
    case noNetwork
    case serverError(String)
    case parsingError(String)
    case unknown(String)
    case invalidRequest
}

extension NetworkError: LocalizedError {
    
    var localizedDescription : String {
        
        switch self {
        case .noNetwork:
            return "Please check you are connected to internet."
        case .serverError(let error):
            return error
        case .parsingError(let error):
            return error
        case .unknown(let url):
            return url
        default:
            return ""
        }
    }
}
