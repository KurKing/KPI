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
            selectedChecker = checkersNodes.min(by: {
                $0.viewPosition.length(to: location) < $1.viewPosition.length(to: location)
            })
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
        if let selectedChecker = selectedChecker {
            selectedChecker.moveToSelfPosition()
            selectedChecker.zPosition = 2
            self.selectedChecker = nil
        }
    }
}

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
        for (index, position) in checkersPositions.enumerated() {
            let node = with(Checker(index: index, viewPosition: position, gamePosition: .zero), setup: {
                $0.name = "\(index)-\($0.gameColor.rawValue)"
                $0.zPosition = 2
            })
            addChild(node)
            checkersNodes.append(node)
        }
    }
    
    func normalize(target: CGFloat, current: CGFloat, maxStep: CGFloat) -> CGFloat {
        if target < current - maxStep {
            return current - maxStep
        }
        if target > current + maxStep {
            return current + maxStep
        }
        return target
    }
}
