//
//  MovieResponseEntity.swift
//  MovieBrowser
//
//  Created by manoj Singireddy on 10/26/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

class MyError: Codable {
    var status_message: String
    var status_code: Int
    
    private enum CodingKeys: String, CodingKey {
        case status_code = "status_code"
        case status_message = "status_message"
    }
}

struct ParserURLResponse {
    
    static func parseURLResponse(response: URLResponse?, data: Data?, completion: onCompletion) {
        if let httpResponse = response as? HTTPURLResponse {
            let code = httpResponse.statusCode
            if code == 200 {
                completion(data, nil)
            }
            else if code == 401 || code == 404 {
                let decoder = JSONDecoder()
                let mData = try? decoder.decode(MyError.self, from: data ?? Data())
                if let responseJSON = mData {
                    return completion(response, NetworkError.unknown(responseJSON.status_message))
                } else {
                    completion(nil, NetworkError.parsingError(Constant.Parsing.message))
                }
            } else {
                completion(nil, NetworkError.unknown(Constant.Parsing.unKnown))
            }
        }
    }
}

