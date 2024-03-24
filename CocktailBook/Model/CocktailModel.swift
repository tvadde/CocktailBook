//
//  CocktailModel.swift
//  CocktailBook
//
//  Created by apple on 3/24/24.
//

import UIKit

struct CocktailModel: Codable {
    let id: String
    let name: String
    let type: String
    let shortDescription: String
    let longDescription: String
    let preparationMinutes: Int
    let imageName: String
    let ingredients: [String]
}
