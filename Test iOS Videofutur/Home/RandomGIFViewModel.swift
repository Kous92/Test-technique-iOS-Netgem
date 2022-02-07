//
//  RandomGIFViewModel.swift
//  Test iOS Videofutur
//
//  Created by Koussaïla Ben Mamar on 07/02/2022.
//

import Foundation
import Combine

final class RandomGIFViewModel {
    private var imageData: GiphySingleResponse?
    private let apiService: APIService
    
    // Les sujets (Subjects), ceux qui émettent et reçoivent des événements
    private var loadedGIF = PassthroughSubject<String, GiphyAPIError>()
    
    /* En programmation réactive fonctionnelle, il faut s'assurer que les Subjects ne soient pas exploités à mauvais escient.
    -> Seul le ViewModel doit émettre des événements, le ViewController qui a une référence avec le ViewModel ne doit pas émettre d'événement, mais seulement s'abonner aux événements.
    -> Les sujets ci-dessus sont donc privés et pour le data binding avec le ViewController, il faut utiliser des AnyPublisher pour que la vue ne s'occupe que de l'abonnement (Subscriber)
    -> Publisher: émétteurs d'événements (équivalent d'Observable en RxSwift)
    -> Subscriber: récepteurs d'événements (équivalent d'Observer en RxSwift)
    */
    var loadedGIFPublisher: AnyPublisher<String, GiphyAPIError> {
        return loadedGIF.eraseToAnyPublisher()
    }
    
    // Injection de dépendance
    init(apiService: APIService = GiphyAPIService()) {
        self.apiService = apiService
    }
    
    func fetchRandomGIF() {
        apiService.getRandomGIF { [weak self] result in
            switch result {
            case .success(let response):
                self?.imageData = response
                self?.parseData()
            case .failure(let error):
                print(error.rawValue)
                self?.loadedGIF.send(completion: .failure(error))
            }
        }
    }
}

extension RandomGIFViewModel {
    private func parseData() {
        guard let gifData = imageData else {
            print("Erreur parsing")
            return
        }
        
        loadedGIF.send(gifData.data.images.original.url)
    }
}
