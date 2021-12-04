//
//  GameScene.swift
//  ClobberGame
//
//  Created by Oleksiy on 04.12.2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override init(size: CGSize) {
        super.init(size: size)
        scaleMode = .aspectFill
        backgroundColor = .clear
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesMoved: \(touches.first?.location(in: self))")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesEnded: \(touches.first?.location(in: self))")
    }
}
