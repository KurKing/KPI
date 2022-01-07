//
//  Sugar.swift
//  TabooGame
//
//  Created by Oleksiy on 07.01.2022.
//

import UIKit

func with<T>(_ object: T, setup:((T)->())) -> T {
    setup(object)
    return object
}

extension Int {
    
    public var hexColor: UIColor {
        .init(red: .init((self & 0xFF0000) >> 16) / 255, green: .init((self & 0x00FF00) >> 8) / 255, blue: .init((self & 0x0000FF) ) / 255, alpha: 1.0)
    }
}

extension Double {
    
    var font: UIFont {
        return UIFont.systemFont(ofSize: CGFloat(self))
    }
    
    var boldFont: UIFont {
        return UIFont.systemFont(ofSize: CGFloat(self), weight: .bold)
    }
}
