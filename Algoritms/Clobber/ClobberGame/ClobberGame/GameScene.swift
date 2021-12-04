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
        createPositionDots()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
}

private extension GameScene {
    
    func createPositionDots() {
        let Y = Int(size.height/4)
        for y in stride(from: -Y+Y/4, through: Y+Y/4-Y/3, by: Y/3) {
            let X = Int(size.width/3)
            for x in stride(from: -X, through: X, by: X/2) {
                addChild(with(SKShapeNode(circleOfRadius: 7)) {
                    $0.fillColor = .mediumRedViolet
                    $0.zPosition = 1
                    $0.position = CGPoint(x: x, y: y)
                })
            }
        }
    }
}
