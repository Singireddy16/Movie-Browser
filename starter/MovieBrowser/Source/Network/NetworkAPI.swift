//
//  NetworkAPI.swift
//  MovieBrowser
//
//  Created by manoj Singireddy on 10/26/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

typealias onCompletion = (Any?, NetworkError?)->()


protocol WebAPIHandler {
    func getDataFromServer(url: String,type: RequestType,completion: @escaping onCompletion)
}

extension WebAPIHandler {
    
    func getDataFromServer(url: String, type: RequestType,completion: @escaping onCompletion) {
        if let request = RequestType(type: type).getURLRequest(url: url) {
            let session = URLSession.shared
            let task = session.dataTask(with: request) { (data, response, error) -> Void in
                ParserURLResponse.parseURLResponse(response: response, data: data, completion: completion)
            }
            task.resume()
        } else {
            completion(nil, NetworkError.invalidRequest)
        }
    }
}

// MARK: - Movie API

struct MovieAPI: WebAPIHandler {
    func getMoviesList(url: String, completion: @escaping onCompletion) {
        getDataFromServer(url: url, type: .MovieList) { (response, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            if let mData = response as? Data {
                let decoder = JSONDecoder()
                let mData = try! decoder.decode(MovieContainer.self, from: mData)
                completion(mData, nil)
            }
        }
    }
}




