//
//  Card.swift
//  TabooGame
//
//  Created by Oleksiy on 08.01.2022.
//

import UIKit

enum CardSuit: String {
    case C = "C"
    case D = "D"
    case H = "H"
    case S = "S"
    
    static var all: [CardSuit] {
        [.C, .D, .H, .S]
    }
    
    var emoji: String {
        switch self {
        case .C:
            return "♣️"
        case .D:
            return "♦️"
        case .H:
            return "♥️"
        case .S:
            return "♠️"
        }
    }
}

struct Card {
    let suit: CardSuit
    let name: String
    
    init(suit: CardSuit, name: String) {
        if !name.isCardName {
            fatalError("Impossible card name: \(name)")
        }
        
        self.suit = suit
        self.name = name
    }
    
    var price: Int {
        switch name {
        case "K":
            return 12
        case "Q":
            return 11
        case "A":
            return 1
        default:
            return 0
        }
    }
    
    var fullName: String { "\(name)\(suit.rawValue)" }
    var displayName: String { "\(name)\(suit.emoji)" }
    var image: UIImage? { fullName.image }
    var isJ: Bool { name == "J" }
}
