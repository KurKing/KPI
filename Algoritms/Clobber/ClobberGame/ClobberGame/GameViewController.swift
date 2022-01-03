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
    private let sceneView = with(SKView()) {
        $0.ignoresSiblingOrder = false
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
    }
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(win), name: .win, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(lose), name: .lose, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func win() {
        showAlert(with: "You win 🥳")
    }
    
    @objc func lose() {
        showAlert(with: "You lose 😢")
    }
    
    private func showAlert(with message: String) {
        let alertViewController = UIAlertController(title: "Game over", message: message, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: { _ in
            NotificationCenter.default.post(name: .restart, object: nil)
        }))
        present(alertViewController, animated: true, completion: nil)
    }
}
