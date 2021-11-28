//
//  Node.swift
//  Al-lab1
//
//  Created by Oleksiy on 20.09.2021.
//

import Foundation

class Node {
    let matrix: Matrix
    let depth: Int
    
    init(matrix: Matrix, depth: Int = 0) {
        self.matrix = matrix
        self.depth = depth
    }
    
    convenience init(matrix: [[Int]], depth: Int = 0) {
        self.init(matrix: Matrix(matrix: matrix), depth: depth)
    }
    
    var isFinish: Bool {
        matrix.isCorrect
    }
    
    var children: [Node] {
        let gap = matrix.gap
        var children = [Node]()
        
        for i in [(1,0),(0,1),(0,-1),(-1,0)] {
            let coordsForSwap: Coords = (x: gap.x+i.0, y: gap.y+i.1)
            
            if coordsForSwap.x >= 0 && coordsForSwap.x < 3 &&
                coordsForSwap.y >= 0 && coordsForSwap.y < 3 {
                let newMatrix = matrix.matrixWithSwap(gap, coordsForSwap)
                children.append(Node(matrix: newMatrix, depth: depth+1))
            }
        }
        
        return children
    }
}
