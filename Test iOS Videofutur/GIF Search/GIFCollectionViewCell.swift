//
//  GIFCollectionViewCell.swift
//  Test iOS Videofutur
//
//  Created by Koussaïla Ben Mamar on 07/02/2022.
//

import Kingfisher
import UIKit

final class GIFCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var gifImage: UIImageView!
    private var viewModel: GIFCellViewModel!
    
    // Injection de dépendance
    func configuration(with viewModel: GIFCellViewModel) {
        self.viewModel = viewModel
        setView()
    }
    
    func setView() {
        self.gifImage.image = nil
        
        guard let imageURL = URL(string: viewModel.fixedSizeUrl) else {
            // print("-> ERREUR: URL de l'image indisponible")
            self.gifImage.image = UIImage(named: "ImageNotAvailable")
            return
        }
        
        // Avec Kingfisher, c'est asynchrone, rapide et efficace. Le cache est géré automatiquement.
        let defaultImage = UIImage(named: "ImageNotAvailable")
        let resource = ImageResource(downloadURL: imageURL)
        gifImage.kf.indicatorType = .activity // Indicateur pendant le téléchargement
        gifImage.kf.setImage(with: resource)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Reset Thumbnail Image View
        gifImage.image = nil
    }
}
