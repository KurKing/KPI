//
//  GameMatrix.swift
//  ClobberGame
//
//  Created by Oleksiy on 10.12.2021.
//

import Foundation

typealias GameMatrix = [[Int]]

extension GameMatrix {
    
    var possibleWhiteSteps: Int { countPossibleSteps(for: 1) }
    var possibleBlackSteps: Int { countPossibleSteps(for: 2) }
    
    var isTerminal: Bool {
        (possibleWhiteSteps + possibleBlackSteps).isZero
    }
    
    var children: [GameMatrix] {
        var children = [GameMatrix]()
        for (y, row) in self.enumerated(){
            for (x, value) in row.enumerated() {
                if value == 2 {
                    if x > 0 && self[y][x-1] == 1 {
                        var newMatrix = self
                        newMatrix[y][x-1] = 2
                        newMatrix[y][x] = 0
                        children.append(newMatrix)
                    }
                    if x < 4 && self[y][x+1] == 1 {
                        var newMatrix = self
                        newMatrix[y][x+1] = 2
                        newMatrix[y][x] = 0
                        children.append(newMatrix)
                    }
                    if y > 0 && self[y-1][x] == 1 {
                        var newMatrix = self
                        newMatrix[y-1][x] = 2
                        newMatrix[y][x] = 0
                        children.append(newMatrix)
                    }
                    if y < 5 && self[y+1][x] == 1 {
                        var newMatrix = self
                        newMatrix[y+1][x] = 2
                        newMatrix[y][x] = 0
                        children.append(newMatrix)
                    }
                }
            }
        }
        return children
    }
    
    private func countPossibleSteps(for color: Int = 2) -> Int {
        var count = 0
        for (y, row) in self.enumerated(){
            for (x, value) in row.enumerated() {
                if value == color {
                    count += (x > 0 && self[y][x-1] != 0 && self[y][x-1] != value).int + (x < 4 && self[y][x+1] != 0 && self[y][x+1] != value).int + (y > 0 && self[y-1][x] != 0 && self[y-1][x] != value).int + (y < 5 && self[y+1][x] != 0 && self[y+1][x] != value).int
                }
            }
        }
        return count
    }
    
    func bestChoice() -> GameMatrix? {
        return children.max(by: { $0.estimate() > $1.estimate() })
    }
    
    private func estimate(deep: Int = 0, prevoiusEstimation: Int = 0) -> Int {
        let countPossibleSteps = countPossibleSteps()
        if deep > 1 || countPossibleSteps < prevoiusEstimation {
            return countPossibleSteps
        }
                
        let estimation = children.map {
            $0.estimate(deep: deep + 1, prevoiusEstimation: countPossibleSteps)
        }.max() ?? 0
        
        return estimation + countPossibleSteps
    }
}
