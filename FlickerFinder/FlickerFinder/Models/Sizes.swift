//
//  Sizes.swift
//  FlickerFinder
//
//  Created by BBVAMobile on 02/02/2021.
//  Copyright © 2021 Alexandre Carvalho. All rights reserved.
//

import Foundation

// MARK: - Sizes
struct Sizes: Codable {
    let sizes: SizesClass
    let stat: String
}

// MARK: - SizesClass
struct SizesClass: Codable {
    let canblog, canprint, candownload: Int
    let sizeArray: [Size]
    
    enum CodingKeys: String, CodingKey {
        case canblog, canprint, candownload
        case sizeArray = "size"
    }
    
    
}

// MARK: - Size
struct Size: Codable {
    let label: String
    let width, height: Int
    let source: String
    let url: String
    let media: Media
}



enum Media: String, Codable {
    case photo = "photo"
}

