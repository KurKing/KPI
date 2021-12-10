//
//  Checker.swift
//  ClobberGame
//
//  Created by Oleksiy on 05.12.2021.
//

import SpriteKit
import GameplayKit

typealias Checkers = [Checker]

enum CheckerColor: String {
    case white = "white"
    case black = "black"
}

class Checker: SKSpriteNode {
    
    let gameColor: CheckerColor
    var viewPosition: CGPoint
    var gamePosition: CGPoint
    
    convenience init(index: Int, viewPosition: CGPoint, gamePosition: CGPoint) {
        self.init(gameColor: index % 2 == 0 ? .black : .white, viewPosition: viewPosition, gamePosition: gamePosition)
    }
    
    init(gameColor: CheckerColor, viewPosition: CGPoint, gamePosition: CGPoint) {
        self.gameColor = gameColor
        self.viewPosition = viewPosition
        self.gamePosition = gamePosition
        
        let texture = SKTexture(imageNamed: "\(gameColor.rawValue)-checker")
        super.init(texture: texture, color: .clear, size: .checkerSize)
        
        position = viewPosition
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        fatalError("init(texture:, color:, size:) is deprecated")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isWhite: Bool {
        gameColor == .white
    }
    
    func moveToSelfPosition() {
        move(to: viewPosition)
    }
    
    func move(to target: CGPoint) {
        run(SKAction.move(to: target, duration: position.time(to: target)))
    }
}

// MARK: - Checkers

extension Checkers {
    
    var gameMatrix: GameMatrix {
        let positions = map { (x: $0.gamePosition.x.int, y: $0.gamePosition.y.int, color: $0.gameColor) }
        var matrix = [[0, 0, 0, 0, 0]]
        for _ in 0..<5 {
            matrix.append([0, 0, 0, 0, 0])
        }
        for i in positions {
            matrix[i.y][i.x] = i.color == .black ? 2 : 1
        }
        return matrix.reversed()
    }
}
