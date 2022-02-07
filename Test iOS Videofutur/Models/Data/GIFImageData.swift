//
//  DataClass.swift
//  Test iOS Videofutur
//
//  Created by Koussaïla Ben Mamar on 07/02/2022.
//

import Foundation

// MARK: - GIFImageData
struct GIFImageData: Decodable {
    var type, id: String
    var url: String
    // var importDatetime, trendingDatetime: String
    var images: Images
}
