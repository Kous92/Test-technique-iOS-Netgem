//
//  APIService.swift
//  Test iOS Videofutur
//
//  Created by Koussaïla Ben Mamar on 07/02/2022.
//

import Foundation

protocol APIService {
    func getRandomGIF(completion: @escaping(Result<GiphySingleResponse, GiphyAPIError>) -> ())
    func searchGIF(query: String, completion: @escaping(Result<GiphyAPIResponse, GiphyAPIError>) -> ())
}
