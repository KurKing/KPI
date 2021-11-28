//
//  Matrix.swift
//  Al-lab1
//
//  Created by Oleksiy on 20.09.2021.
//

import Foundation

typealias Coords = (x: Int, y: Int)

class Matrix {
    
    let matrix: [[Int]]
    let h1: Int
    let gap: Coords
    
    init(matrix: [[Int]], h1: Int, gap: Coords) {
        self.matrix = matrix
        self.h1 = h1
        self.gap = gap
    }
    
    convenience init(matrix: [[Int]]) {
        let configurator = MatrixCongigurator()
        self.init(matrix: matrix, h1: configurator.h1(for: matrix), gap: configurator.gap(for: matrix))
    }
    
    var isCorrect: Bool {
        self.matrix == [[0,1,2],[3,4,5],[6,7,8]]
    }
    
    func matrixWithSwap(_ first: Coords, _ second: Coords) -> [[Int]] {
        var newMatrix = matrix
        newMatrix[first.y][first.x] = value(for: second)
        newMatrix[second.y][second.x] = value(for: first)
        return newMatrix
    }
    
    private func value(for coords: Coords) -> Int {
        return matrix[coords.y][coords.x]
    }
}

// MARK: - Utility
private extension Matrix {
    struct MatrixCongigurator {
        func gap(for matrix: [[Int]]) -> Coords {
            for y in 0..<3 {
                for x in 0..<3 {
                    if matrix[y][x] == 0 {
                        return (x: x, y: y)
                    }
                }
            }
            fatalError("no 0 inside matrix")
        }
        
        func h1(for matrix: [[Int]]) -> Int {
            var count = 0
            let correctMatrix = [[0,1,2],[3,4,5],[6,7,8]]
            for y in 0..<3 {
                for x in 0..<3 {
                    if matrix[y][x] != correctMatrix[y][x] {
                        count += 1
                    }
                }
            }
            
            return count
        }
    }
}

// MARK: - Equatable
extension Matrix: Equatable {
    
    static func == (lhs: Matrix, rhs: Matrix) -> Bool {
        lhs.matrix == rhs.matrix
    }
}

// MARK: - Random matrix
extension Matrix {
    
    static var random: Matrix {
        var array = (0..<9).shuffled()
        var matrix = [[0,0,0],[0,0,0],[0,0,0]]
        for y in 0..<3 {
            for x in 0..<3 {
                matrix[y][x] = array.removeFirst()
            }
        }
        return Matrix(matrix: matrix)
    }
}
