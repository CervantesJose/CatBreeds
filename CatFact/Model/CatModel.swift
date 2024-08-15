//
//  Model.swift
//  BreedFact
//
//  Created by Jose Cervantes on 8/14/24.
//

import Foundation

struct Breed: Codable {
    let breed: String
    let country: String
    let origin: String
    let coat: String
    let pattern: String
}

struct Response: Codable {
    let data: [Breed]
}
