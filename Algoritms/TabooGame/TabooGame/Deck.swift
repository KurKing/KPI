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
    
    weak var delegate: ViewController?
    
    private var selectedPayerCardIndex = 0
    
    init(delegate: ViewController) {
        self.delegate = delegate
        
        for name in cardsNames.split(separator: " ") {
            for suit in CardSuit.all {
                reserv.append(Card(suit: suit, name: "\(name)"))
            }
        }
        for _ in 0...10 {
            reserv.shuffle()
        }
        
        for _ in 0..<5 {
            player.append(reserv.remove(at: 0))
        }
    }
    
    var nextPlayerCard: Card {
        selectedPayerCardIndex += 1
        if selectedPayerCardIndex >= player.count {
            selectedPayerCardIndex -= player.count
        }
        
        return player[selectedPayerCardIndex]
    }
    
    func placeCardsOnTable() {
        while currentTable.count < 4 {
            let nextCard = reserv.remove(at: 0)
            if !nextCard.isJ {
                currentTable.append(nextCard)
            }
        }
        delegate?.refreshTable()
    }
    
    func step() {
        var match = false
        for p in player {
            for t in currentTable {
                if p.name == t.name {
                    match = true
                }
            }
        }
        
        if match || player[selectedPayerCardIndex].isJ {
            playerStep()
        } else {
            player.append(reserv.remove(at: 0))
            reserv.shuffle()
        }
        
        selectedPayerCardIndex = -1
        delegate?.updatePlayerCard()
    }
    
    private func playerStep() {
        let currentCard = player[selectedPayerCardIndex]
        var match = false
        
        if currentCard.isJ {
            match = true
            currentTable.removeAll()
        } else {
            currentTable.removeAll(where: {
                $0.name == currentCard.name
            })
            match = currentTable.count != 4
        }
        
        if match {
            player.remove(at: selectedPayerCardIndex)
            placeCardsOnTable()
            selectedPayerCardIndex = -1
            delegate?.updatePlayerCard()
        }
    }
}
