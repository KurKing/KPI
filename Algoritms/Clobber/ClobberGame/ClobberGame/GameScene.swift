//
//  GameScene.swift
//  ClobberGame
//
//  Created by Oleksiy on 04.12.2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let engine: GameEngine
    
    override init(size: CGSize) {
        engine = GameEngine(for: size)
        super.init(size: size)
        isPaused = true
        scaleMode = .aspectFill
        backgroundColor = .clear
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        NotificationCenter.default.addObserver(self, selector: #selector(restartGame), name: .restart, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        addChildren(engine.createDots)
        addChildren(engine.createCheckers)
        isPaused = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self) {
            engine.touchBegan(location: location)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self) {
            engine.touchMoved(location: location)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self) {
            engine.touchesEnded(location: location)
        }
    }
    
    @objc func restartGame() {
        isPaused = true
        removeAllChildren()
        addChildren(engine.createDots)
        addChildren(engine.createCheckers)
        isPaused = false
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
