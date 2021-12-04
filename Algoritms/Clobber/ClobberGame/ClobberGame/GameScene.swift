//
//  GameScene.swift
//  ClobberGame
//
//  Created by Oleksiy on 04.12.2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let checkersPositions: [CGPoint]
    
    override init(size: CGSize) {
        var checkersPositions = [CGPoint]()
        let Y = Int(size.height/4)
        for y in stride(from: -Y+Y/4, through: Y+Y/4-Y/3, by: Y/3) {
            let X = Int(size.width/3)
            for x in stride(from: -X, through: X, by: X/2) {
                checkersPositions.append(CGPoint.init(x: x, y: y))
            }
        }
        self.checkersPositions = checkersPositions
        
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
        createCheckers()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
}

private extension GameScene {
    
    func createPositionDots() {
        for position in checkersPositions {
            addChild(with(SKShapeNode(circleOfRadius: 7)) {
                $0.fillColor = .mediumRedViolet
                $0.zPosition = 1
                $0.position = position
            })
        }
    }
    
    func createCheckers() {
        for (index, position) in checkersPositions.enumerated() {
            let colorName = "\(index % 2 == 0 ? "black" : "white")-checker"

            addChild(with(SKSpriteNode(texture: .init(imageNamed: colorName), color: .clear, size: 40.size), setup: {
                $0.name = colorName
                $0.position = position
                $0.zPosition = 2
            }))
        }
    }
}
