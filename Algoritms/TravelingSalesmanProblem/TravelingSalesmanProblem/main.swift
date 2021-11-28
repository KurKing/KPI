//
//  main.swift
//  TravelingSalesmanProblem
//
//  Created by Oleksiy on 26.11.2021.
//

import Foundation

let lengthMatrix = Random.lengthMatrix(citiesAmount: 300)

let configs = [
    HiveConfiguration(activeBeesNumber: 50,
                      inactiveBeesNumber: 20,
                      scoutBeesNumber: 30,
                      maxCycles: 4000,
                      maxVisits: 100,
                      lengthMatrix: lengthMatrix),
    HiveConfiguration(activeBeesNumber: 50*2,
                      inactiveBeesNumber: 20*2,
                      scoutBeesNumber: 30*2,
                      maxCycles: 4000,
                      maxVisits: 100,
                      lengthMatrix: lengthMatrix),
    HiveConfiguration(activeBeesNumber: 50*4,
                      inactiveBeesNumber: 20*4,
                      scoutBeesNumber: 30*4,
                      maxCycles: 4000,
                      maxVisits: 100,
                      lengthMatrix: lengthMatrix),
    HiveConfiguration(activeBeesNumber: 50*8,
                      inactiveBeesNumber: 20*8,
                      scoutBeesNumber: 30*8,
                      maxCycles: 4000,
                      maxVisits: 100,
                      lengthMatrix: lengthMatrix)
]

for configuration in configs {
    let hive = Hive(configs: configuration)
    let timeStart = Date().timeIntervalSinceReferenceDate
    let solution = hive.solve()
    print("Quality: \(solution.quality); Time: \(Date().timeIntervalSinceReferenceDate - timeStart)\n\(solution.solution)")
}
