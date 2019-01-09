//
//  PokemonModel.swift
//  TeamWork (Jason & Olimpia)
//
//  Created by Olimpia on 1/9/19.
//  Copyright © 2019 Olimpia. All rights reserved.
//

import Foundation
struct Cards: Codable{
    let cards: [Pokemon]
}


struct Pokemon: Codable {
    let name: String?
    let imageUrlHiRes: String
    let types: [String]
    let hp: String?
    let attacks: [AllAttacks]
}

struct AllAttacks: Codable {
    let name: String
    let text: String
    let damage: String?
}
