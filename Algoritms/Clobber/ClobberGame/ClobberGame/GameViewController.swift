//
//  GameViewController.swift
//  ClobberGame
//
//  Created by Oleksiy on 04.12.2021.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var gameView: UIView!
    private lazy var scene = GameScene()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = .title
        
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.isTranslucent = false
            navigationBar.standardAppearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.textColor,
                NSAttributedString.Key.font: 24.boldFont
            ]
            navigationBar.standardAppearance.shadowColor = nil
            navigationBar.standardAppearance.backgroundColor = .mediumRedViolet
            navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        }
        
        let sceneView = SKView(frame: gameView.frame)
        sceneView.ignoresSiblingOrder = false
        sceneView.backgroundColor = .clear
        gameView.addSubview(sceneView)

        scene.setUp(size: gameView.bounds.size)
        sceneView.presentScene(scene)
    }
}

