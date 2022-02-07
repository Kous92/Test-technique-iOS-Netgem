//
//  NetworkRequest.swift
//  Test iOS Videofutur
//
//  Created by Koussaïla Ben Mamar on 07/02/2022.
//

import Foundation
import Alamofire

final class NetworkRequest {
    func getRequest<T: Decodable>(endpoint: GiphyAPIEndpoint, completion: @escaping (Result<T, GiphyAPIError>) -> ()) {
        guard let url = URL(string: endpoint.baseURL + endpoint.path) else {
            completion(.failure(.invalidURL))
            return
        }
        
        AF.request(url).validate().responseDecodable(of: T.self) { response in
            switch response.result {
            case .success:
                guard let data = response.value else {
                    completion(.failure(.downloadError))
                    return
                }
                
                completion(.success(data))
                
                
            case let .failure(error):
                print("La requête a échoué")
                guard let httpResponse = response.response else {
                    print("ERREUR: \(error)")
                    completion(.failure(.networkError))
                    return
                }
                
                switch httpResponse.statusCode {
                case 400:
                    completion(.failure(.badRequest))
                case 404:
                    completion(.failure(.notFound))
                case 429:
                    completion(.failure(.tooManyRequests))
                case 500:
                    completion(.failure(.serverError))
                default:
                    completion(.failure(.unknown))
                }
            }
        }
    }
}
