//
//  GameViewController.swift
//  ClobberGame
//
//  Created by Oleksiy on 04.12.2021.
//

import UIKit

class GameViewController: UIViewController {

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
            navigationBar.standardAppearance.backgroundColor = .mainColor
            navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        }
    }
}

