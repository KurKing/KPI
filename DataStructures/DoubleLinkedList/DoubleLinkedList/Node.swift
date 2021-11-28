//
//  Node.swift
//  DoubleLinkedList
//
//  Created by Oleksiy on 05.02.2021.
//

import Foundation

class Node<T: Comparable> {
    var value: T
    
    weak var predecessorNode: Node<T>?
    var nextNode: Node<T>?
    
    init(_ value: T) {
        self.value = value
    }
    
    func clearReferences(){
        predecessorNode = nil
        nextNode = nil
    }
}

enum NodeType {
    case first
    case last
}
