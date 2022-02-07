//
//  GIFFullScreenViewModel.swift
//  Test iOS Videofutur
//
//  Created by Koussaïla Ben Mamar on 07/02/2022.
//

import Foundation

final class GIFFullScreenViewModel {
    let imageURL: String
    
    // Injection de dépendance
    init(with viewModel: GIFCellViewModel) {
        self.imageURL = viewModel.originalSizeUrl
    }
}
