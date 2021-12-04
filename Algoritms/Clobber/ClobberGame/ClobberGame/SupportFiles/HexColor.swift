//
//  HexColor.swift
//  ClobberGame
//
//  Created by Oleksiy on 04.12.2021.
//

import UIKit

extension Int {
    public var hexColor: UIColor {
        return UIColor(red:CGFloat((self & 0xFF0000) >> 16) / 255 , green: CGFloat((self & 0x00FF00) >> 8) / 255, blue: CGFloat((self & 0x0000FF) ) / 255, alpha: 1.0)
    }
}
