//
//  MagicModel.swift
//  TeamWork (Jason & Olimpia)
//
//  Created by Olimpia on 1/9/19.
//  Copyright © 2019 Olimpia. All rights reserved.
//

import Foundation

struct Cards: Codable {
    let cards: [MagicCards]
}

 struct MagicCards: Codable {
    var name: String
    var imageUrl: String?
    var foreignNames: [ForeignNamesInfo]
    
    struct ForeignNamesInfo: Codable {
        var name: String
        var text: String
        var imageUrl: String
        var language: String
    }
}




