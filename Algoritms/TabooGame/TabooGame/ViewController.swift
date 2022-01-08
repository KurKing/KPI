//
//  ViewController.swift
//  TabooGame
//
//  Created by Oleksiy on 07.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var playerCardImageView: UIImageView!
    
    @IBOutlet weak var firstCardImageView: UIImageView!
    @IBOutlet weak var secondCardImageView: UIImageView!
    @IBOutlet weak var thirdCardImageView: UIImageView!
    @IBOutlet weak var forthCardImageView: UIImageView!
    
    @IBOutlet weak var stepButton: UIButton!
    @IBOutlet weak var nextCardButton: UIButton!
    
    var cardImageViews: [UIImageView] {
        [firstCardImageView, secondCardImageView,
         thirdCardImageView, forthCardImageView]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardImageViews.forEach {
            $0.image = Card(suit: .D, name: "Q").image
        }
        
        let deck = Deck()
        for card in deck.cards {
            print("\(card.name)\(card.suit.rawValue) - \(card.price)")
        }
    }
    
    @IBAction func nextCardButtonPressed() {
        print("nextCardButtonPressed")
    }
    
    @IBAction func stepButtonPressed(_ sender: Any) {
        print("stepButtonPressed")
    }
    
}
