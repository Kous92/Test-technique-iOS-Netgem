//
//  GIFSearchViewModel.swift
//  Test iOS Videofutur
//
//  Created by Koussaïla Ben Mamar on 07/02/2022.
//

import Foundation
import Combine

final class GIFSearchViewModel {
    private var gifsData: GiphyAPIResponse?
    
    var gifCellViewModels = [GIFCellViewModel]()
    private let apiService: APIService
    
    // Pour la gestion mémoire et l'annulation des abonnements
    private var subscriptions = Set<AnyCancellable>()
    
    // Les sujets, ceux qui émettent et reçoivent des événements
    private var updateResult = PassthroughSubject<Bool, GiphyAPIError>()
    private var isLoading = PassthroughSubject<Bool, Never>()
    
    /* En programmation réactive fonctionnelle, il faut s'assurer que les Subjects ne soient pas exploités à mauvais escient.
    -> Seul le ViewModel doit émettre des événements, le ViewController qui a une référence avec le ViewModel ne doit pas émettre d'événement, mais seulement s'abonner aux événements.
    -> Les sujets ci-dessus sont donc privés et pour le data binding avec le ViewController, il faut utiliser des AnyPublisher pour que la vue ne s'occupe que de l'abonnement (Subscriber)
     -> Publisher: émétteurs d'événements (équivalent d'Observable en RxSwift)
     -> Subscriber: récepteurs d'événements (équivalent d'Observer en RxSwift)
    */
    var updateResultPublisher: AnyPublisher<Bool, GiphyAPIError> {
        return updateResult.eraseToAnyPublisher()
    }
    
    var isLoadingPublisher: AnyPublisher<Bool, Never> {
        return isLoading.eraseToAnyPublisher()
    }
    
    // Lorsque son contenu est modifié depuis le ViewController, le Publisher va réagir et automatiquement effectuer un appel HTTP en fonction du contenu (après filtrage).
    @Published var searchQuery = ""
    
    // Injection de dépendance
    init(apiService: APIService = GiphyAPIService()) {
        self.apiService = apiService
        setBindings()
    }
    
    private func setBindings() {
        $searchQuery
            .receive(on: RunLoop.main)
            .removeDuplicates()
            .filter { !$0.isEmpty }
            .debounce(for: .seconds(1.0), scheduler: RunLoop.main)
            .sink { [weak self] value in
                self?.searchGIF()
            }.store(in: &subscriptions)
    }
    
    private func searchGIF() {
        isLoading.send(true)
        
        apiService.searchGIF(query: searchQuery) { [weak self] result in
            switch result {
            case .success(let response):
                self?.gifsData = response
                self?.parseData()
            case .failure(let error):
                print(error.rawValue)
                self?.updateResult.send(completion: .failure(error))
            }
        }
    }
    
    private func parseData() {
        guard let data = gifsData?.data, data.count > 0 else {
            // Pas d'image disponible
            updateResult.send(false)
            
            return
        }
        
        gifCellViewModels.removeAll()
        data.forEach { gifCellViewModels.append(GIFCellViewModel(with: $0)) }
        updateResult.send(true)
    }
}
