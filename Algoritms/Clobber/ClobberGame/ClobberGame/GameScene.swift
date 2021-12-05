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
    let xStep: Int
    let yStep: Int
    var checkersNodes = [Checker]()
    var selectedChecker: Checker? = nil
    
    override init(size: CGSize) {
        var checkersPositions = [CGPoint]()
        xStep = Int(size.width)/3
        yStep = Int(size.height)/4
        for y in stride(from: -yStep+yStep/4, through: yStep+yStep/4-yStep/3, by: yStep/3) {
            for x in stride(from: -xStep, through: xStep, by: xStep/2) {
                checkersPositions.append(CGPoint.init(x: x, y: y))
            }
        }
        self.checkersPositions = checkersPositions
        
        super.init(size: size)
        isPaused = true
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
        isPaused = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self), selectedChecker == nil {
            selectedChecker = nearestChecker(to: location)
            selectedChecker?.zPosition = 3
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self),
           let checkerToMove = selectedChecker {
            
            checkerToMove.move(to: CGPoint(
                x: normalize(target: location.x, current: checkerToMove.viewPosition.x, maxStep: CGFloat(xStep/2)),
                y: normalize(target: location.y, current: checkerToMove.viewPosition.y, maxStep: CGFloat(yStep/3))
            ))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let selectedChecker = selectedChecker,
           let touchLocation = touches.first?.location(in: self),
           let nearestChecker = nearestChecker(to: touchLocation),
           selectedChecker.gamePosition.x == nearestChecker.gamePosition.x || selectedChecker.gamePosition.y == nearestChecker.gamePosition.y,
           selectedChecker.position.length(to: nearestChecker.viewPosition) < CGSize.checkerSize.width,
           selectedChecker.gameColor != nearestChecker.gameColor {
            
            selectedChecker.move(to: nearestChecker.viewPosition)
            selectedChecker.viewPosition = nearestChecker.viewPosition
            selectedChecker.gamePosition = nearestChecker.gamePosition
            nearestChecker.removeFromParent()
            checkersNodes.removeAll(where: { $0 == nearestChecker })
        }
        
        selectedChecker?.moveToSelfPosition()
        selectedChecker?.zPosition = 2
        selectedChecker = nil
    }
}

// MARK: - Utils

private extension GameScene {

    func normalize(target: CGFloat, current: CGFloat, maxStep: CGFloat) -> CGFloat {
        if target < current - maxStep {
            return current - maxStep
        }
        if target > current + maxStep {
            return current + maxStep
        }
        return target
    }
    
    func nearestChecker(to location: CGPoint) -> Checker? {
        return checkersNodes.min(by: {
            $0.viewPosition.length(to: location) < $1.viewPosition.length(to: location)
        })
    }
}

// MARK: - Creation

private extension GameScene {
    
    func createPositionDots() {
        for position in checkersPositions {
            addChild(with(SKShapeNode(circleOfRadius: .dotRadius)) {
                $0.fillColor = .mediumRedViolet
                $0.zPosition = 1
                $0.position = position
            })
        }
    }
    
    func createCheckers() {
        var gamePosition = CGPoint.zero
        for (index, position) in checkersPositions.enumerated() {
            let node = with(Checker(index: index, viewPosition: position, gamePosition: gamePosition), setup: {
                $0.name = "\(index)-\($0.gameColor.rawValue)"
                $0.zPosition = 2
            })
            
            gamePosition.x += 1
            if (gamePosition.x > 4) {
                gamePosition.y += 1
                gamePosition.x -= 5
            }
            
            addChild(node)
            checkersNodes.append(node)
        }
    }
}
