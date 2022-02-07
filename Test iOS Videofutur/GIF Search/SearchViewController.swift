//
//  SearchViewController.swift
//  Test iOS Videofutur
//
//  Created by Koussaïla Ben Mamar on 07/02/2022.
//

import UIKit
import Combine

class SearchViewController: UIViewController {
    
    @IBOutlet weak var gifCollectionView: UICollectionView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel = GIFSearchViewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchBar()
        setCollectionView()
        setBindings()
    }
}

extension SearchViewController {
    private func setCollectionView() {
        // Configuration CollectionView
        gifCollectionView.isHidden = true
        gifCollectionView.dataSource = self
        gifCollectionView.delegate = self
    }
    
    private func setSearchBar() {
        // Configuration barre de recherche
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Annuler"
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .label
        searchBar.backgroundImage = UIImage() // Supprimer le fond par défaut
        searchBar.showsCancelButton = false
        searchBar.delegate = self
    }
    
    private func updateCollectionView() {
        gifCollectionView.isHidden = false
        gifCollectionView.reloadData()
    }
    
    private func setBindings() {
        func setUpdateBinding() {
            viewModel.updateResultPublisher
                .receive(on: RunLoop.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("OK: terminé")
                    case .failure(let error):
                        print("Erreur reçue: \(error.rawValue)")
                    }
                } receiveValue: { [weak self] updated in
                    self?.spinner.stopAnimating()
                    self?.spinner.isHidden = true
                    
                    if updated {
                        self?.updateCollectionView()
                    }
                }.store(in: &subscriptions)
        }
        
        func setLoadingBinding() {
            viewModel.isLoadingPublisher
                .receive(on: RunLoop.main)
                .sink { [weak self] isLoading in
                    if isLoading {
                        self?.spinner.startAnimating()
                        self?.spinner.isHidden = false
                        self?.gifCollectionView.isHidden = true
                    }
                }.store(in: &subscriptions)
        }
        // L'intérêt d'utiliser des fonctions imbriquées est de pouvoir respecter le 1er prinicipe du SOLID étant le principe de responsabilité unique (SRP: Single Responsibility Principle)
        setLoadingBinding()
        setUpdateBinding()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.setShowsCancelButton(true, animated: true) // Afficher le bouton d'annulation
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.searchQuery = searchText
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.searchQuery = ""
        self.searchBar.text = ""
        self.searchBar.setShowsCancelButton(false, animated: true) // Masquer le bouton d'annulation
        searchBar.resignFirstResponder() // Masquer le clavier et stopper l'édition du texte
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // Masquer le clavier et stopper l'édition du texte
        self.searchBar.setShowsCancelButton(false, animated: true) // Masquer le bouton d'annulation
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        gifCollectionView.deselectItem(at: indexPath, animated: true)
        
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "fullScreen") as? GIFFullScreenViewController else {
            print("Erreur instanciation vue.")
            return
        }
        
        // Injection de dépendance, on exploite le contenu du programme sélectionné, stockée dans la vue modèle associée à la cellule du CollectionView.
        viewController.configure(with: GIFFullScreenViewModel(with: viewModel.gifCellViewModels[indexPath.row]))
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.gifCellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let gifCell = gifCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? GIFCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        gifCell.configuration(with: viewModel.gifCellViewModels[indexPath.row])
        
        return gifCell
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    // Par exemple 2 colonnes sur iPhone et 4 sur iPad
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 180)
    }
}
