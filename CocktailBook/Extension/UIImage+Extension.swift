//
//  UIImage+Extension.swift
//  CocktailBook
//
//  Created by apple on 3/26/24.
//

import Foundation

enum ImageName: String {
    case heart = "heart"
    case heartFill = "heart.fill"
    case rightArrowFill = "arrowtriangle.right.fill"
    case timer = "timer"
}

extension UIImage {
    
    static func getImage(_ name: ImageName) ->  UIImage {
        return UIImage(systemName: name.rawValue)
    }
}
