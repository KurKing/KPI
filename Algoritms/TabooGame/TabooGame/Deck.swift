//
//  Deck.swift
//  TabooGame
//
//  Created by Oleksiy on 08.01.2022.
//

import Foundation

class Deck {
    
    var reserv = [Card]()
    var player = [Card]()
    var currentTable = [Card]()
    
    private var selectedPayerCardIndex = 0
    
    init() {
        for name in cardsNames.split(separator: " ") {
            for suit in CardSuit.all {
                reserv.append(Card(suit: suit, name: "\(name)"))
            }
        }
        reserv.shuffle()
        
        for _ in 0..<5 {
            player.append(reserv.remove(at: 0))
        }
        
        while currentTable.count < 4 {
            let nextCard = reserv.remove(at: 0)
            if !nextCard.isJ {
                currentTable.append(nextCard)
            }
        }
    }
    
    var nextPlayerCard: Card {
        selectedPayerCardIndex += 1
        if selectedPayerCardIndex >= player.count {
            selectedPayerCardIndex -= player.count
        }
        
        return player[selectedPayerCardIndex]
    }
}
