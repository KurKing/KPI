//
//  SparsedList.swift
//  SparsedList
//
//  Created by Oleksiy on 22.03.2021.
//

import Foundation

class SparsedList<T: Comparable> {
    
    private var rootNode: Node<T>?
    private(set) var notNilNodesAmount = 0
    
    func get(x: Int, y: Int, z: Int) -> T? {
        var node = rootNode
        
        while let currentNode = node {
            if currentNode.x == x && currentNode.y == y && currentNode.z == z {
                return currentNode.value
            }
            node = currentNode.nextNode
        }
        
        return nil
    }
    
    func set(x: Int, y: Int, z: Int, value: T){
        let newNode = Node(x: x, y: y, z: z, value: value)
        notNilNodesAmount+=1
        
        guard let root = rootNode else {
            rootNode = newNode
            
            return
        }
        
        if newNode.isCoordinatesSmaller(than: root) {
            newNode.nextNode = root
            rootNode = newNode
            
            return
        }
        
        var node = root
        while !newNode.isCoordinatesSmaller(than: node.nextNode ?? Node(x: Int.max, y: Int.max, z: Int.max, value: root.value)) {
            guard let nextNode = node.nextNode else {
                break
            }
            node = nextNode
        }
        
        if newNode.x == node.x && newNode.y == node.y && newNode.z == node.z {
            node.value = value
            notNilNodesAmount-=1
            return
        }
        
        newNode.nextNode = node.nextNode
        node.nextNode = newNode
    }
    
    func sortNonEmpty() {
        guard var current: Node<T>? = rootNode else {
            return
        }
        
        while current != nil {
            var index = current!.nextNode
            
            while index != nil {
                
                if current!.value > index!.value {
                    swapNodes(node1: current!, node2: index!)
                }
                
                index = index?.nextNode;
            }
            
            current = current?.nextNode;
        }
    }
    
    private func swapNodes(node1: Node<T>, node2: Node<T>) {
        let temp = node1.value;
        node1.value = node2.value;
        node2.value = temp;
    }
    
    func toString() -> String {
        var node = rootNode
        var res = ""
        
        while let nodeToPrint = node {
            res += "\(nodeToPrint.toString())\n"
            node = nodeToPrint.nextNode
        }
        
        return res
    }
    
}
