//
//  Node.swift
//  SparsedList
//
//  Created by Oleksiy on 22.03.2021.
//

import Foundation

class Node<T: Comparable> {
    let x: Int
    let y: Int
    let z: Int
    
    var value: T
    var nextNode: Node<T>?
    
    init(x: Int, y: Int, z: Int, value: T) {
        self.x = x
        self.y = y
        self.z = z
        
        self.value = value
    }
        
    func isCoordinatesSmaller(than otherNode: Node<T>) -> Bool {

        if x < otherNode.x {
            return true
        }
        
        if x == otherNode.x {
            if y < otherNode.y {
                return true
            }
            
            if y == otherNode.y {
                return z < otherNode.z
            }
        }
        
        return false
    }
    
    func toString() -> String {
        return "x: \(x), y: \(y), z: \(z); value: \(value)"
    }
    
}
