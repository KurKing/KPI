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
    
    private(set) var deck: Deck!

    var cardImageViews: [UIImageView] {
        [firstCardImageView, secondCardImageView,
         thirdCardImageView, forthCardImageView]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deck = Deck(delegate: self)
        playerCardImageView.image = deck.player[0].image
        
        deck.placeCardsOnTable()
    }
    
    private func setRandomCardTo(imageView: UIImageView) {
        imageView.image = deck.reserv.randomElement()!.image
    }
    
    @IBAction func nextCardButtonPressed() {
        playerCardImageView.image = deck.nextPlayerCard.image
    }
    
    @IBAction func stepButtonPressed(_ sender: Any) {
        deck.step()
    }
    
    func refreshTable() {
        for (index, imageView) in cardImageViews.enumerated() {
            imageView.image = deck.currentTable[index].image
        }
    }
    
    func updatePlayerCard() {
        playerCardImageView.image = deck.nextPlayerCard.image
    }
}
