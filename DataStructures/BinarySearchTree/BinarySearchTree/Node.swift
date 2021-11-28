//
//  Node.swift
//  Tree
//
//  Created by Oleksiy on 15.01.2021.
//

import Foundation

///Node of Tree
class Node<T: Comparable>: Comparable {
    
    let value: T
    weak var parent: Node<T>?
    
    var rigthNode: Node<T>?
    var leftNode: Node<T>?
    
    init(value: T, parent: Node<T>) {
        self.value = value
        self.parent = parent
    }
    
    init(value: T) {
        self.value = value
    }
    
    static func < (lhs: Node<T>, rhs: Node<T>) -> Bool {
        return lhs.value < rhs.value
    }
    
    static func == (lhs: Node<T>, rhs: Node<T>) -> Bool {
        return lhs.value == rhs.value
    }
}
