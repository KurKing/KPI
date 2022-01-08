//
//  Deck.swift
//  TabooGame
//
//  Created by Oleksiy on 08.01.2022.
//

import Foundation

class Deck {
    
    var cards = [Card]()
    
    init() {
        for name in cardsNames.split(separator: " ") {
            for suit in CardSuit.all {
                cards.append(Card(suit: suit, name: "\(name)"))
            }
        }
        cards.shuffle()
    }
}
