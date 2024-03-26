//
//  ColorID.swift
//  CocktailBook
//
//  Created by apple on 3/26/24.
//

import Foundation
import UIKit

enum ColorID: String {
    case color = "0"
    case color1 = "1"
    case color2 = "2"
    case color3 = "3"
    case color4 = "4"
    case color5 = "5"
    case color6 = "6"
    case color7 = "7"
    case color8 = "8"
    case color9 = "9"
    case color10 = "10"
    case color11 = "11"
    case color12 = "12"
}

// Extend the enum to provide a computed property that returns the corresponding UIColor
extension ColorID {
    var uiColor: UIColor {
        switch self {
        case .color:
            return .red
        case .color1:
            return .blue
        case .color2:
            return .green
        case .color3:
            return .cyan
        case .color4:
            return .yellow
        case .color5:
            return .magenta
        case .color6:
            return .orange
        case .color7:
            return .purple
        case .color8:
            return .brown
        case .color9:
            return .gray
        case .color10:
            return UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1.0)
        case .color11:
            return UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        case .color12:
            return UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0)
        }
    }
}
