//
//  Color.swift
//  Opera
//
//  Created by Mahmoud Abdul-Wahab on 20/06/2021.
//

import UIKit

extension DesignSystem {
    
    enum Color: String {
        case nowPlaying
        case search
        case releaseDate
        
        var UIColor: UIColor {
            return UIKit.UIColor(named: self.rawValue)!
        }
    }
        
    static func getColorFor(_ text: String) -> UIColor {
        var hash = 0
        let colorConstant = 131
        let maxSafeValue = Int.max / colorConstant
        for char in text.unicodeScalars {
            if hash > maxSafeValue {
                hash = hash / colorConstant
            }
            hash = Int(char.value) + ((hash << 5) - hash)
        }
        let finalHash = abs(hash) % (256 * 256 * 256)
        let color = UIColor(hue: CGFloat(finalHash) / 255.0, saturation: 0.15, brightness: 0.90, alpha: 1.0)
        return color
    }
    
}


