//
//  GameEngine.swift
//  ClobberGame
//
//  Created by Oleksiy on 05.12.2021.
//

import SpriteKit
import GameplayKit

class GameEngine {
    
    let checkersPositions: [CGPoint]
    let xStep: Int
    let yStep: Int
    var checkersNodes = Checkers()
    var selectedChecker: Checker? = nil
    
    var å = 0
    var ß = 0

    init(for size: CGSize) {
        var checkersPositions = [CGPoint]()
        xStep = Int(size.width)/3
        yStep = Int(size.height)/4
        for y in stride(from: -yStep+yStep/4, through: yStep+yStep/4-yStep/3, by: yStep/3) {
            for x in stride(from: -xStep, through: xStep, by: xStep/2) {
                checkersPositions.append(CGPoint.init(x: x, y: y))
            }
        }
        self.checkersPositions = checkersPositions
    }
}

// MARK: - GameLogic

extension GameEngine {
    func touchBegan(location: CGPoint) {
        if selectedChecker == nil, let nearestChecker = nearestChecker(to: location), nearestChecker.isWhite {
            selectedChecker = with(nearestChecker, setup: {
                $0.zPosition = 3
            })
        }
    }
    
    func touchMoved(location: CGPoint) {
        if let checkerToMove = selectedChecker {
            
            checkerToMove.move(to: CGPoint(
                x: normalize(target: location.x, current: checkerToMove.viewPosition.x, maxStep: CGFloat(xStep/2)),
                y: normalize(target: location.y, current: checkerToMove.viewPosition.y, maxStep: CGFloat(yStep/3))
            ))
        }
    }
    
    func touchesEnded(location: CGPoint) {
        if let selectedChecker = selectedChecker,
           let nearestChecker = nearestChecker(to: location),
           isAbleToSwap(selectedChecker, with: nearestChecker) {
            
            selectedChecker.move(to: nearestChecker.viewPosition)
            selectedChecker.viewPosition = nearestChecker.viewPosition
            selectedChecker.gamePosition = nearestChecker.gamePosition
            nearestChecker.removeFromParent()
            checkersNodes.removeAll(where: { $0 == nearestChecker })
            
            let gameMatrix = checkersNodes.gameMatrix
            if !gameMatrix.isTerminal {
                let nextBestChoice = gameMatrix.bestChoice()!
                print(nextBestChoice)
                var changes = [(Int, Int)]()
                for (y, row) in gameMatrix.children.randomElement()!.enumerated(){
                    for (x, value) in row.enumerated() {
                        if gameMatrix[y][x] != value {
                            changes.append((y,x))
                        }
                    }
                }
                step(for: changes)
            }
        }
        
        selectedChecker?.moveToSelfPosition()
        selectedChecker?.zPosition = 2
        selectedChecker = nil
    }
    
    private func step(for changes: [(Int, Int)]) {
        if changes.count != 2 {
            return
        }
        
        print(checkersNodes.map({ $0.gamePosition }))
        print(changes)
        
        guard let firstNode = checkersNodes.first(where: {
            $0.gamePosition == CGPoint(x: changes[0].1, y: changes[0].0)
        }),
        let secondNode = checkersNodes.first(where: {
            $0.gamePosition == CGPoint(x: changes[1].1, y: changes[1].0)
        }) else {
            return
        }
        if firstNode.gameColor == .black {
            firstNode.move(to: secondNode.position)
            
            firstNode.gamePosition = secondNode.gamePosition
            firstNode.viewPosition = secondNode.viewPosition
//            firstNode.position = secondNode.position
            
            secondNode.removeFromParent()
            checkersNodes.remove(at: checkersNodes.firstIndex(of: secondNode)!)
        } else {
            secondNode.move(to: firstNode.position)
            
            secondNode.gamePosition = firstNode.gamePosition
            secondNode.viewPosition = firstNode.viewPosition
//            secondNode.position = firstNode.position
            
            firstNode.removeFromParent()
            checkersNodes.remove(at: checkersNodes.firstIndex(of: firstNode)!)
        }
    }
}

// MARK: - Creation

extension GameEngine {
    
    var createDots: [SKShapeNode] {
        var dots = [SKShapeNode]()
        for position in checkersPositions {
            dots.append(
                with(SKShapeNode(circleOfRadius: .dotRadius)) {
                    $0.fillColor = .mediumRedViolet
                    $0.zPosition = 1
                    $0.position = position
                }
            )
        }
        return dots
    }
    
    var createCheckers: [SKSpriteNode] {
        checkersNodes = []
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
            checkersNodes.append(node)
        }
        return checkersNodes
    }
}

// MARK: - Utils

private extension GameEngine {
    
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
    
    func isAbleToSwap(_ first: Checker, with second: Checker) -> Bool {
        return (first.gamePosition.x == second.gamePosition.x || first.gamePosition.y == second.gamePosition.y)
        && first.position.length(to: second.viewPosition) < CGSize.checkerSize.width
         && first.gameColor != second.gameColor
    }
}
