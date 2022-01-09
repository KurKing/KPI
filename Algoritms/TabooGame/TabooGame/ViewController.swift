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
            if index >= deck.currentTable.count {
                imageView.image = nil
            } else {
                imageView.image = deck.currentTable[index].image
            }
        }
    }
    
    func updatePlayerCard() {
        playerCardImageView.image = deck.nextPlayerCard.image
    }
    
    func showNewCardAlert(with name: String) {
        let alert = UIAlertController(title: "New card", message: "\(name)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showGameOverAlert(playerScore: Int, opponentScore: Int) {
        let alert = UIAlertController(
            title: playerScore > opponentScore ? "You win" : "You lose",
            message: "Your score: \(playerScore).\nOpponent score: \(opponentScore)",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        
        deck = Deck(delegate: self)
        playerCardImageView.image = deck.player[0].image
        deck.placeCardsOnTable()
    }
}
