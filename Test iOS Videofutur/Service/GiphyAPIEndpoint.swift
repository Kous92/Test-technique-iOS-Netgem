//
//  GiphyAPIEndpoint.swift
//  Test iOS Videofutur
//
//  Created by Koussaïla Ben Mamar on 07/02/2022.
//

import Foundation

enum GiphyAPIEndpoint {
    case singleRandomGIF(key: String)
    case searchGIF(key: String, query: String, language: String)
    
    
    var baseURL: String {
        return "https://api.giphy.com/v1/gifs/"
    }
    
    var path: String {
        switch self {
        case .singleRandomGIF(let key):
            return "random?api_key=\(key)&tag=&rating=g"
        case .searchGIF(let key, let query, let language):
            return "search?api_key=\(key)&q=\(query),&limit=25&offset=0&rating=g&lang=\(language)"
        }
    }
}
