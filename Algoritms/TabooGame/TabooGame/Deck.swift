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
    var opponent = [Card]()
    var currentTable = [Card]()
    var playerPreScore = 0
    var opponentPreScore = 0
    
    var playerScore: Int {
        playerPreScore - player.map({ $0.price }).reduce(0, +)
    }
    
    var opponentScore: Int {
        opponentPreScore - opponent.map({ $0.price }).reduce(0, +)
    }
    
    weak var delegate: ViewController?
    
    private var selectedPayerCardIndex = 0
    
    init(delegate: ViewController) {
        self.delegate = delegate
        
        for suit in CardSuit.all {
            for name in cardsNames.split(separator: " ") {
                reserv.append(Card(suit: suit, name: "\(name)"))
            }
        }
        for _ in 0..<10 {
            reserv.shuffle()
        }
        
        for _ in 0..<5 {
            player.append(reserv.remove(at: 0))
        }
        
        for _ in 0..<5 {
            opponent.append(reserv.remove(at: 0))
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
        while currentTable.count < 4 && !reserv.isEmpty {
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
        
        if player.isEmpty {
            delegate?.showGameOverAlert(playerScore: playerScore, opponentScore: opponentScore)
        }
        
        if match || player.contains(where: { $0.isJ }) {
            playerStep()
        } else {
            player.append(reserv.remove(at: 0))
            delegate?.showNewCardAlert(with: player[player.count-1].displayName)
            reserv.shuffle()
        }
        
        selectedPayerCardIndex = -1
        delegate?.updatePlayerCard()
        
        if reserv.isEmpty || player.isEmpty {
            delegate?.showGameOverAlert(playerScore: playerScore, opponentScore: opponentScore)
        }
        
        opponentStep()
    }
    
    private func playerStep() {
        let currentCard = player[selectedPayerCardIndex]
        var match = false
        
        if currentCard.isJ {
            match = true
            playerPreScore += currentTable
                .map({ $0.price })
                .reduce(0, +)
            currentTable.removeAll()
        } else {
            playerPreScore += currentTable
                .filter({ $0.name == currentCard.name })
                .map({ $0.price })
                .reduce(0, +)
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
    
    private func opponentStep() {
        let potentialSteps = opponent.filter({ card in
            card.isJ || currentTable.contains(where: { card.name == $0.name })
        })
        
        if potentialSteps.isEmpty {
            if reserv.isEmpty {
                delegate?.showGameOverAlert(playerScore: playerScore, opponentScore: opponentScore)
            } else {
                opponent.append(reserv.remove(at: 0))
                delegate?.showOpponentStepAlert(with: "+1 card")
            }
            return
        }
        
        let selectedCard = potentialSteps.randomElement()!
        
        if selectedCard.isJ {
            opponentPreScore += currentTable
                .map({ $0.price })
                .reduce(0, +)
            currentTable.removeAll()
        } else {
            opponentPreScore += currentTable
                .filter({ $0.name == selectedCard.name })
                .map({ $0.price })
                .reduce(0, +)
            currentTable.removeAll(where: {
                $0.name == selectedCard.name
            })
        }

        opponent.removeAll(where: { $0.name == selectedCard.name && $0.suit == selectedCard.suit })
        
        if reserv.isEmpty || opponent.isEmpty {
            delegate?.showGameOverAlert(playerScore: playerScore, opponentScore: opponentScore)
            return
        }
        
        placeCardsOnTable()
        delegate?.showOpponentStepAlert(with: selectedCard.displayName)
    }
}
