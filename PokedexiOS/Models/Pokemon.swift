//
//  Pokemon.swift
//  PokedexiOS
//
//  Created by Tasuku Yamamoto on 4/26/22.
//

import Foundation

class Pokemon: Decodable {
    
    //MARK: - Properties
    let name: String
    let id: Int
    let sprites: SpriteObject
    
}//End of class

struct SpriteObject: Decodable {
    let classicSpriteURL: URL
    
    //to avoid snake_case name
    enum CodingKeys: String, CodingKey{
        case classicSpriteURL = "front_default"
    }
}
