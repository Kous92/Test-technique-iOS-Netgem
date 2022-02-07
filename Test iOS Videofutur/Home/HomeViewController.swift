//
//  HomeViewController.swift
//  Test iOS Videofutur
//
//  Created by Koussaïla Ben Mamar on 07/02/2022.
//

import UIKit
import Kingfisher
import Combine

class HomeViewController: UIViewController {

    @IBOutlet weak var gifImageView: UIImageView!
    
    private var subscriptions = Set<AnyCancellable>()
    private var viewModel = RandomGIFViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBindings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.fetchRandomGIF()
    }
    
    private func setBindings() {
        viewModel.loadedGIFPublisher
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("OK: terminé")
                case .failure(let error):
                    print("Erreur reçue: \(error.rawValue)")
                }
            } receiveValue: { [weak self] url in
                guard let imageURL = URL(string: url) else {
                    self?.gifImageView.image = UIImage(named: "ImageNotAvailable")
                    return
                }
                
                self?.updateGIF(url: imageURL)
            }.store(in: &subscriptions)
    }
}

extension HomeViewController {
    private func updateGIF(url: URL) {
        let resource = ImageResource(downloadURL: url)
        gifImageView.kf.indicatorType = .activity
        gifImageView.kf.setImage(with: resource)
    }
}
