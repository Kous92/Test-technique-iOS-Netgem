//
//  Image.swift
//  Test iOS Videofutur
//
//  Created by Koussaïla Ben Mamar on 07/02/2022.
//

import Foundation

// MARK: - Images
struct Images: Decodable {
    var original: FixedHeight
    var fixedHeight: FixedHeight

    enum CodingKeys: String, CodingKey {
        case original
        case fixedHeight = "fixed_height"
    }
}
