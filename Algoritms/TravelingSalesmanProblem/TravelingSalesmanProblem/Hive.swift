//
//  Hive.swift
//  TravelingSalesmanProblem
//
//  Created by Oleksiy on 26.11.2021.
//

import Foundation

typealias Solution = [Int]

// MARK: - HiveConfiguration

struct HiveConfiguration {
    
    var activeBeesNumber: Int
    var inactiveBeesNumber: Int
    let scoutBeesNumber: Int
    
    var beesNumber: Int {
        activeBeesNumber + inactiveBeesNumber + scoutBeesNumber
    }
    
    let maxCycles: Int
    let maxVisits: Int
    
    let probPersuasion = 0.9;
    let probMistake = 0.01;
    
    let lengthMatrix: [[Int]]
}

// MARK: - Hive

class Hive {
    
    private var configs: HiveConfiguration
    
    private var bees: [Bee]
    private var bestSolution: Solution
    private var bestQuality: Int
    private var inactiveBees: [Bee]
    
    init(configs: HiveConfiguration) {
        self.configs = configs
        self.bees = []
        self.inactiveBees = []
        self.bestSolution = []
        self.bestQuality = Int.max
        
        for i in 0..<configs.beesNumber {
            let type: BeeType = i < configs.activeBeesNumber ? .active : (i < configs.activeBeesNumber + configs.scoutBeesNumber ? .scout : .inactive)
            let solution = randomSolution
            let quality = countQuality(for: solution)
            let bee = Bee(type: type, solution: solution, quality: quality)
            bees.append(bee)
            if quality < bestQuality {
                bestQuality = quality
                bestSolution = solution
            }
            
            if type == .inactive {
                inactiveBees.append(bee)
            }
        }
    }
    
    func solve() -> (solution: Solution, quality: Int) {
        
        for cycle in 0..<configs.maxCycles {
            for bee in bees {
                switch bee.type {
                case .inactive:
                    break
                case .active:
                    processActive(bee)
                    break
                case .scout:
                    processScout(bee)
                    break
                }
            }
            
            if cycle % 100 == 0 {
                print("cycle: \(cycle); quality: \(bestQuality)")
            }
        }
        
        return (solution: bestSolution, quality: bestQuality)
    }
}

// MARK: - Process

extension Hive {
    
    func processActive(_ bee: Bee) {
        let neighborSolution = neighborSolution(for: bee.solution)
        let neighborSolutionQuality = countQuality(for: neighborSolution)
        let prob = Double.random(in: 0...1)
        var numberOfVisitsOverLimit = false
        var memoryWasUpdated = false
        
        if neighborSolutionQuality < bee.quality {
            
            if prob < configs.probMistake {
                bee.numberOfVisits += 1
                if bee.numberOfVisits > configs.maxVisits {
                    numberOfVisitsOverLimit = true
                }
            } else {
                bee.solution = neighborSolution
                bee.quality = neighborSolutionQuality
                bee.numberOfVisits = 0
                memoryWasUpdated = true
            }
        } else {
            
            if prob < configs.probMistake {
                bee.solution = neighborSolution
                bee.quality = neighborSolutionQuality
                bee.numberOfVisits = 0
                memoryWasUpdated = true
            } else {
                bee.numberOfVisits += 1
                if bee.numberOfVisits > configs.maxVisits {
                    numberOfVisitsOverLimit = true
                }
            }
        }
        
        if numberOfVisitsOverLimit {
            bee.type = .inactive
            bee.numberOfVisits = 0
            
            let randomInactiveBeeIndex = Int.random(in: 0..<inactiveBees.count)
            let inactiveBee = inactiveBees[randomInactiveBeeIndex]
            inactiveBees.remove(at: randomInactiveBeeIndex)
            inactiveBee.type = .active
            
            inactiveBees.append(bee)
        } else if memoryWasUpdated {
            if bee.quality < bestQuality {
                bestQuality = bee.quality
                bestSolution = bee.solution
            }
            waggleDance(from: bee)
        }
    }
    
    func processScout(_ bee: Bee) {
        let randomSolution = randomSolution
        let randomSolutionQuality = countQuality(for: randomSolution)
        
        if randomSolutionQuality < bee.quality {
            bee.solution = randomSolution
            bee.quality = randomSolutionQuality
            if bee.quality < bestQuality {
                bestQuality = bee.quality
                bestSolution = bee.solution
            }
            waggleDance(from: bee)
        }
    }
}

// MARK: - WaggleDance

extension Hive {
    
    func waggleDance(from bee: Bee) {
        for inactiveBee in inactiveBees {
            if bee.quality < inactiveBee.quality {
                if Double.random(in: 0...1) < configs.probPersuasion {
                    inactiveBee.quality = bee.quality
                    inactiveBee.solution = bee.solution
                }
            }
        }
    }
}

// MARK: - Util

extension Hive {
    
    var randomSolution: Solution {
        return (0..<configs.lengthMatrix.count).shuffled()
    }
    
    func countQuality(for solution: Solution) -> Int {
        var length = 0
        for i in 0..<(solution.count-1) {
            length += lenthBetween(firstCity: solution[i], secondCity: solution[i+1])
        }
        return length
    }
    
    func lenthBetween(firstCity: Int, secondCity: Int) -> Int {
        return configs.lengthMatrix[firstCity][secondCity]
    }
    
    func neighborSolution(for solution: Solution) -> Solution {
        var result = solution
        let randomIndex = Int.random(in: 0..<solution.count)
        let adjustableIndex: Int = randomIndex == solution.count - 1 ? 0 : randomIndex + 1
        let temp = result[randomIndex]
        result[randomIndex] = result[adjustableIndex]
        result[adjustableIndex] = temp
        return result
    }
}
