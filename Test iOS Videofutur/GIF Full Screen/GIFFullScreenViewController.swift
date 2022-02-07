//
//  GIFFullScreenViewController.swift
//  Test iOS Videofutur
//
//  Created by Koussaïla Ben Mamar on 07/02/2022.
//

import UIKit
import Kingfisher

class GIFFullScreenViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var fullScreenGifImage: UIImageView!
    var viewModel: GIFFullScreenViewModel!
    
    // Injection de dépendance
    func configure(with viewModel: GIFFullScreenViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let imageURL = URL(string: viewModel.imageURL) else {
            // print("-> ERREUR: URL de l'image indisponible")
            self.fullScreenGifImage.image = UIImage(named: "ImageNotAvailable")
            return
        }
        
        setGIF(url: imageURL)
    }
    
    @IBAction func backToSearchView(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension GIFFullScreenViewController {
    private func setGIF(url: URL) {
        let defaultImage = UIImage(named: "ImageNotAvailable")
        let resource = ImageResource(downloadURL: url)
        fullScreenGifImage.kf.indicatorType = .activity
        fullScreenGifImage.kf.setImage(with: resource)
    }
}
