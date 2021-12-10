//
//  Helpers.swift
//  ClobberGame
//
//  Created by Oleksiy on 04.12.2021.
//

import UIKit
import SpriteKit
import GameplayKit

func with<T>(_ object: T, setup:((T)->())) -> T {
    setup(object)
    return object
}

extension Int {
    
    public var hexColor: UIColor {
        .init(red: .init((self & 0xFF0000) >> 16) / 255, green: .init((self & 0x00FF00) >> 8) / 255, blue: .init((self & 0x0000FF) ) / 255, alpha: 1.0)
    }
    
    public var size: CGSize {
        .init(width: .init(self), height: .init(self))
    }
    
    public var isZero: Bool {
        self == 0
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

extension Bool {
    
    var int: Int {
        self ? 1 : 0
    }
}

extension CGFloat {
    
    var int: Int {
        Int(self)
    }
}

extension CGPoint {
    
    func time(to target: CGPoint) -> TimeInterval {
        return TimeInterval(length(to: target)/Double.checkerSpeed)
    }
    
    func length(to target: CGPoint) -> Double {
        sqrt(pow(x-target.x, 2)+pow(y-target.y, 2))
    }
}

extension SKScene {
    
    func addChildren(_ nodes: [SKNode]) {
        nodes.forEach {
            addChild($0)
        }
    }
}
