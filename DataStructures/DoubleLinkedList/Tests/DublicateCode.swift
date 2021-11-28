//
//  DublicateCode.swift
//  Tests
//
//  Created by Oleksiy on 06.02.2021.
//

import Foundation

/*
 I can`t import all classes correct because it`s command line tool
 So, I just dublicate code.
 I know that it`s bad, but I can`t solve this problem
 So, maybe someone can help me???
*/

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

protocol List {
    associatedtype T: Comparable

    func insert(value: T, at index: Int)
    func insert(value: T)
    
    func remove(at index: Int)

    func replace(at index: Int, with value: T)

    func index(of value: T) -> Int?
    
    func toArray() -> [T]

    var count: Int { get }
}

class DoubleLinkedList<T: Comparable>: List {
    
    typealias T = T
    
    private var size = 0
    
    private var root: Node<T>?
    private var tail: Node<T>?
    
    var count: Int {
        return size
    }
    
    //MARK: - Insert
    /// insert a node at index
    func insert(value: T, at index: Int) {
        
        if index > size || index < 0 {
            print("Invalid index for insertion! Index: \(index); Current list size: \(size)")
            return
        }
        
        if index == 0 {
            insertAtTheBeginning(value)
        } else if index == size {
            insertAtTheEnd(value)
        } else {
            insertInTheMiddle(value: value, at: index)
        }
        
        size += 1
    }
    
    /// insert a node at the end of the list
    func insert(value: T){
        insert(value: value, at: size)
    }
    
    /// insert a node at the end or beginning of the list
    func insert(value: T, as type: NodeType){
        switch type {
        case .first:
            insert(value: value, at: 0)
        case .last:
            insert(value: value, at: size)
        }
    }
    
    //MARK: insertAtTheEnd
    private func insertAtTheEnd(_ value: T) {
        if tail == nil {
            tail = Node(value)
            root?.nextNode = tail
            tail?.predecessorNode = root
            
            return
        }
        
        tail?.nextNode = Node(value)
        tail?.nextNode?.predecessorNode = tail
        
        tail = tail?.nextNode
    }
    
    //MARK: insertAtTheBeginning
    private func insertAtTheBeginning(_ value: T) {
        guard let root = root else {
            self.root = Node(value)
            return
        }
        
        let nodeAfterRoot = root
        self.root = Node(value)
        self.root?.nextNode = nodeAfterRoot
        nodeAfterRoot.predecessorNode = self.root
        
        if size == 1 {
            self.tail = nodeAfterRoot
        }
    }
    
    //MARK: insert in the middle
    private func insertInTheMiddle(value: T, at index: Int) {
        let nodeAfterInsertedNode = findNode(with: index)
        
        let newNode = Node(value)
        nodeAfterInsertedNode.predecessorNode?.nextNode = newNode
        newNode.predecessorNode = nodeAfterInsertedNode.predecessorNode
        newNode.nextNode = nodeAfterInsertedNode
        nodeAfterInsertedNode.predecessorNode = newNode
    }
    
    //MARK: findNode
    private func findNode(with index: Int) -> Node<T> {
        var node: Node<T>
        
        if index < size / 2 + 1{
            
            var counter = 0
            node = root!
            
            while counter != index {
                node = node.nextNode!
                counter += 1
            }
            
        } else {
            var counter = size-1
            node = tail!
            
            while counter != index {
                node = node.predecessorNode!
                counter -= 1
            }
        }
        
        return node
    }
    
    //MARK: - Remove
    /// remove first or last element
    func remove(_ type: NodeType) {
        switch type {
        case .first:
            remove(at: 0)
        case .last:
            remove(at: size)
        }
    }
    /// remove element with specified index
    func remove(at index: Int) {
        
        if index > size || index < 0 {
            print("Invalid index for insertion! Index: \(index); Current list size: \(size)")
            return
        }
        
        if index == 0 {
            let nodeToRemove = root
            root = root?.nextNode
            nodeToRemove?.clearReferences()
        } else if index == size {
            let nodeToRemove = tail
            tail = tail?.predecessorNode
            tail?.nextNode = nil
            nodeToRemove?.clearReferences()
        } else {
            let nodeToRemove = findNode(with: index)
            
            nodeToRemove.predecessorNode?.nextNode = nodeToRemove.nextNode
            nodeToRemove.nextNode?.predecessorNode = nodeToRemove.predecessorNode
        }
        
        size -= 1
    }
    
    //MARK: - Replace
    /// replace element value at specified index with new one
    func replace(at index: Int, with value: T) {
        if index == size {
            tail?.value = value
            return
        }
        findNode(with: index).value = value
    }
    
    //MARK: - Index
    /// return index of element with specified value; if element doesn't exist return nil
    func index(of value: T) -> Int? {
        var counter = 0
        guard var node = root else {
            return nil
        }
        
        while node.value != value {
            guard  let nextNode = node.nextNode else {
                return nil
            }
            node = nextNode
            counter += 1
        }
        
        return counter
    }
    
    //MARK: - To array
    /// return all values as array
    func toArray() -> [T] {
        guard var node = root else {
            return []
        }
        var array = [node.value]
        
        while let nodeToAppend = node.nextNode {
            array.append(nodeToAppend.value)
            node = nodeToAppend
        }
        
        return array
    }
}

