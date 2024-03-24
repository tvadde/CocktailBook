//
//  Constant.swift
//  CocktailBook
//
//  Created by apple on 3/24/24.
//

import Foundation

enum CocktailType: String, CaseIterable {
    case all = "All"
    case alcoholic = "Alcoholic"
    case nonAlcoholic = "Non-Alcoholic"
    
    var getTypeWithCocktail: String {
        return self.rawValue + "  Cocktails"
    }
    
}

