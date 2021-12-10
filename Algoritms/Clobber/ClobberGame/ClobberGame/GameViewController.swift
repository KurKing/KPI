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
    private var scene: GameScene!
    
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
        
        let sceneView = with(SKView()) {
            $0.ignoresSiblingOrder = false
            $0.backgroundColor = .clear
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.clipsToBounds = true
        }
        gameView.addSubview(sceneView)
        NSLayoutConstraint.activate([
            sceneView.topAnchor.constraint(equalTo: gameView.topAnchor),
            sceneView.bottomAnchor.constraint(equalTo: gameView.bottomAnchor),
            sceneView.leftAnchor.constraint(equalTo: gameView.leftAnchor),
            sceneView.rightAnchor.constraint(equalTo: gameView.rightAnchor)
        ])
        
        view.layoutIfNeeded()
        
        scene = GameScene(size: sceneView.bounds.size)
        sceneView.presentScene(scene)
    }
}
