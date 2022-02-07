//
//  GiphyAPIService.swift
//  Test iOS Videofutur
//
//  Created by Koussaïla Ben Mamar on 07/02/2022.
//

import Foundation
import Alamofire

final class GiphyAPIService: APIService {
    private let apiKey: String = "jJFc597R1PAf3XNCULfo76j6EyWZqHHY"
    private let networkRequest = NetworkRequest()
    
    func getRandomGIF(completion: @escaping (Result<GiphySingleResponse, GiphyAPIError>) -> ()) {
        networkRequest.getRequest(endpoint: .singleRandomGIF(key: apiKey), completion: completion)
    }
    
    func searchGIF(query: String, completion: @escaping (Result<GiphyAPIResponse, GiphyAPIError>) -> ()) {
        networkRequest.getRequest(endpoint: .searchGIF(key: apiKey, query: query.addingPercentEncoding(withAllowedCharacters: .afURLQueryAllowed) ?? "", language: "fr"), completion: completion)
    }
}
