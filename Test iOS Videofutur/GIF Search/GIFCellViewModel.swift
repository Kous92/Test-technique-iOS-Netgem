//
//  GIFCollectionViewCellViewModel.swift
//  Test iOS Videofutur
//
//  Created by Koussaïla Ben Mamar on 07/02/2022.
//

import Foundation

final class GIFCellViewModel {
    let originalSizeUrl: String
    let fixedSizeUrl: String
    
    // Injection de dépendance
    init(with data: GIFImageData) {
        self.originalSizeUrl = data.images.original.url
        self.fixedSizeUrl = data.images.fixedHeight.url
    }
}
