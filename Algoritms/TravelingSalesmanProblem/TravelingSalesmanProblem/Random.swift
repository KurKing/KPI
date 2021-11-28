//
//  Random.swift
//  TravelingSalesmanProblem
//
//  Created by Oleksiy on 26.11.2021.
//

import Foundation

struct Random {
    static func lengthMatrix(citiesAmount: Int) -> [[Int]] {
        var matrix = [[Int]]()
        
        for _ in 0..<citiesAmount {
            var row = [Int]()
            for _ in 0..<citiesAmount {
                row.append(0)
            }
            matrix.append(row)
        }
        
        for x in 0..<citiesAmount {
            for y in 0..<citiesAmount {
                if matrix[x][y] == 0 && x != y {
                    let length = Int.random(in: 5...150)
                    matrix[x][y] = length
                    matrix[y][x] = length
                }
            }
        }
        
        return matrix
    }
}
