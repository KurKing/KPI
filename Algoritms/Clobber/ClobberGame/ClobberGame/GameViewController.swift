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
            navigationBar.standardAppearance.backgroundColor = .mediumRedViolet
            navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        }
        
        let bgImage: UIImageView = .init(image: .init(named: "bg-blurred"))
        view.addSubview(bgImage)
        NSLayoutConstraint.activate([
            bgImage.topAnchor.constraint(equalTo: view.topAnchor),
            bgImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bgImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgImage.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

