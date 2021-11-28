//
//  Tree.swift
//  Tree
//
//  Created by Oleksiy on 15.01.2021.
//

import Foundation

///Tree class
class Tree<T: Comparable>{
    
    private var rootNode: Node<T>?
    /// amount of nodes
    private(set) var size = 0
    
    //MARK: Add node
    ///add new node
    func add(_ newValue: T){
        size += 1

        guard let node = rootNode else {
            rootNode = Node(value: newValue)
            return
        }

        add(newValue: newValue, node: node)
    }
    
    private func add(newValue: T, node: Node<T>){

        if newValue < node.value {
            
            guard let leftNode = node.leftNode else {
                node.leftNode = Node(value: newValue, parent: node)
                return
            }
            add(newValue: newValue, node: leftNode)
            
        } else {
            
            guard let rightNode = node.rigthNode else {
                node.rigthNode = Node(value: newValue, parent: node)
                return
            }
            add(newValue: newValue, node: rightNode)
            
        }
    }
    
    private func add(to rootNode: Node<T>, node: Node<T>){
        
        if node.value < rootNode.value {
            
            guard let leftNode = rootNode.leftNode else {
                rootNode.leftNode = node
                rootNode.leftNode!.parent = rootNode
                return
            }
            add(to: leftNode, node: node)
            
        } else {
            
            guard let rightNode = rootNode.rigthNode else {
                rootNode.rigthNode = node
                rootNode.rigthNode!.parent = rootNode
                return
            }
            add(to: rightNode, node: node)
        }
    }
    
    //MARK: Remove node
    /// use to delete a node;
    func removeNode(with value: T) {
        
        guard let rootNode = self.rootNode else {
            return
        }
        
        guard let nodeToRemove = getNode(with: value, node: rootNode) else {
            return
        }
        
        size -= 1
        
        if nodeToRemove == self.rootNode{
            self.rootNode = nodeToRemove.rigthNode
            if let root = self.rootNode {
               root.parent = nil
                
                if let leftNode = nodeToRemove.leftNode {
                    add(to: root, node: leftNode)
                }
            }
        
            return
        }
        
        removeChildNode(nodeToRemove, from: nodeToRemove.parent!)
        
        if let rigthNode = nodeToRemove.rigthNode, let parent = nodeToRemove.parent {
            add(to: parent, node: rigthNode)
        }
        if let leftNode = nodeToRemove.leftNode, let parent = nodeToRemove.parent {
            add(to: parent, node: leftNode)
        }
    }
    
    private func removeChildNode(_ child: Node<T>, from parent: Node<T>){
        if parent.rigthNode == child {
            parent.rigthNode = nil
        }
        if parent.leftNode == child {
            parent.leftNode = nil
        }
    }
    
    //MARK: Getters
    func get(value: T) -> T? {
        return getNode(with: value, node: rootNode)?.value
    }
    
    ///get node by value
    private func getNode(with value: T, node: Node<T>?) -> Node<T>?{
        
        guard let node = node else {
            return nil
        }
        
        if value == node.value {
            return node
        }
        
        if value < node.value {
            return getNode(with: value, node: node.leftNode)
        } else {
            return getNode(with: value, node: node.rigthNode)
        }
    }
    
    /// get most left node value
    func getMinValue() -> T? {
        var currentNode = rootNode
        
        while let node = currentNode?.leftNode {
            currentNode = node
        }
        
        return currentNode?.value
    }
    
    /// get most rigth node value
    func getMaxValue() -> T? {
        var currentNode = rootNode
        
        while let node = currentNode?.rigthNode {
            currentNode = node
        }
        
        return currentNode?.value
    }
    
    //MARK: - To Array
    func toArray() -> [T]{
        guard let rootNode = self.rootNode else {
            return []
        }
        
        var nodeArray: [T] = []
        
        toArray(node: rootNode, nodeArray: &nodeArray)
        
        return nodeArray
    }
    
    private func toArray(node: Node<T>, nodeArray: inout[T]){
        if let leftNode = node.leftNode {
            toArray(node: leftNode, nodeArray: &nodeArray)
        }
        
        if let rigthNode = node.rigthNode {
            toArray(node: rigthNode, nodeArray: &nodeArray)
        }
        
        nodeArray.append(node.value)
    }
}
