//
//  AppFont.swift
//  ClobberGame
//
//  Created by Oleksiy on 04.12.2021.
//

import UIKit

extension Double {
    
    var font: UIFont {
        return UIFont.systemFont(ofSize: CGFloat(self))
    }
    
    var boldFont: UIFont {
        return UIFont.systemFont(ofSize: CGFloat(self), weight: .bold)
    }
}
