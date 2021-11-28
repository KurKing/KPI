//
//  Bee.swift
//  TravelingSalesmanProblem
//
//  Created by Oleksiy on 26.11.2021.
//

import Foundation

enum BeeType {
    case active, inactive, scout
}

class Bee {
    
    var type: BeeType
    var solution: [Int]
    var quality: Int
    var numberOfVisits: Int
    
    init(type: BeeType, solution: [Int], quality: Int, numberOfVisits: Int = 0) {
        self.type = type
        self.solution = solution
        self.quality = quality
        self.numberOfVisits = numberOfVisits
    }
}
