//
//  RBTree.swift
//  RBTree
//
//  Created by Oleksiy on 29.03.2021.
//

import Foundation

class RedBlackTree<T: Comparable> {
    private typealias RBNode = RBTreeNode<T>
    
    private var root: RBNode
    private(set) var size = 0
    private let nullLeaf = RBNode()
    private let allowDuplicateNode: Bool
    
    init(_ allowDuplicateNode: Bool = false) {
        root = nullLeaf
        self.allowDuplicateNode = allowDuplicateNode
    }
    
    public func count() -> Int {
        return size
    }
    
    public func isEmpty() -> Bool {
        return size == 0
    }
    
    public func toArray(time: TimeInterval) -> [T] {
        var nodes: [T] = []
        
        toArray(node: root, nodes: &nodes, time: time)
        
        return nodes
    }
    
    //MARK: - Search
    func minValue() -> T? {
        guard let minNode = root.minimum() else {
            return nil
        }
        return minNode.key
    }

    func maxValue() -> T? {
        guard let maxNode = root.maximum() else {
            return nil
        }
        return maxNode.key
    }
    
    func seachValue(input: T) -> T? {
        return search(input: input)?.key
    }
    
    private func search(input: T) -> RBNode? {
        return search(key: input, node: root)
    }
    
    private func search(key: T, node: RBNode?) -> RBNode? {
        guard let node = node else {
            return nil
        }
        if !node.isNullLeaf {
            if let nodeKey = node.key {
                if key == nodeKey {
                    return node
                } else if key < nodeKey {
                    return search(key: key, node: node.leftChild)
                } else {
                    return search(key: key, node: node.rightChild)
                }
            }
        }
        return nil
    }
    
    //MARK: - Insert
    func insert(key: T) {
        if search(input: key) != nil && !allowDuplicateNode {
            return
        }
        
        if root.isNullLeaf {
            root = RBNode(key: key)
        } else {
            insert(input: RBNode(key: key), node: root)
        }
        
        size += 1
    }
    
    private func insert(input: RBNode, node: RBNode) {
        guard let inputKey = input.key, let nodeKey = node.key else {
            return
        }
        if inputKey < nodeKey {
            guard let child = node.leftChild else {
                addAsLeftChild(child: input, parent: node)
                return
            }
            if child.isNullLeaf {
                addAsLeftChild(child: input, parent: node)
            } else {
                insert(input: input, node: child)
            }
        } else {
            guard let child = node.rightChild else {
                addAsRightChild(child: input, parent: node)
                return
            }
            if child.isNullLeaf {
                addAsRightChild(child: input, parent: node)
            } else {
                insert(input: input, node: child)
            }
        }
    }
    
    private func addAsLeftChild(child: RBNode, parent: RBNode) {
        parent.leftChild = child
        child.parent = parent
        child.color = .red
        insertFixup(node: child)
    }
    
    private func addAsRightChild(child: RBNode, parent: RBNode) {
        parent.rightChild = child
        child.parent = parent
        child.color = .red
        insertFixup(node: child)
    }

    private func insertFixup(node z: RBNode) {
        if !z.isNullLeaf {
            guard let parentZ = z.parent else {
                return
            }

            if parentZ.color == .red {
                guard let uncle = z.uncle else {
                    return
                }

                if uncle.color == .red {
                    parentZ.color = .black
                    uncle.color = .black
                    if let grandparentZ = parentZ.parent {
                        grandparentZ.color = .red
                        insertFixup(node: grandparentZ)
                    }
                } else {
                    var zNew = z
                    if parentZ.isLeftChild && z.isRightChild {
                        zNew = parentZ
                        leftRotate(node: zNew)
                    } else if parentZ.isRightChild && z.isLeftChild {
                        zNew = parentZ
                        rightRotate(node: zNew)
                    }
                    zNew.parent?.color = .black
                    if let grandparentZnew = zNew.grandparent {
                        grandparentZnew.color = .red
                        if z.isLeftChild {
                            rightRotate(node: grandparentZnew)
                        } else {
                            leftRotate(node: grandparentZnew)
                        }
                    }
                }
            }
        }
        root.color = .black
    }
    
    //MARK: - Delete node
    func delete(key: T) {
        if size == 1 {
            root = nullLeaf
            size -= 1
        } else if let node = search(key: key, node: root) {
            if !node.isNullLeaf {
                delete(node: node)
                size -= 1
            }
        }
    }
    
    private func delete(node z: RBNode) {
        var nodeY = RBNode()
        var nodeX = RBNode()
        if let leftChild = z.leftChild, let rightChild = z.rightChild {
            if leftChild.isNullLeaf || rightChild.isNullLeaf {
                nodeY = z
            } else {
                if let successor = z.getSuccessor() {
                    nodeY = successor
                }
            }
        }
        if let leftChild = nodeY.leftChild {
            if !leftChild.isNullLeaf {
                nodeX = leftChild
            } else if let rightChild = nodeY.rightChild {
                nodeX = rightChild
            }
        }
        nodeX.parent = nodeY.parent
        if let parentY = nodeY.parent {
            // Should never be the case, as parent of root = nil
            if parentY.isNullLeaf {
                root = nodeX
            } else {
                if nodeY.isLeftChild {
                    parentY.leftChild = nodeX
                } else {
                    parentY.rightChild = nodeX
                }
            }
        } else {
            root = nodeX
        }
        if nodeY.key != z.key {
            z.key = nodeY.key
        }

        if nodeY.color == .black {
            deleteFixup(node: nodeX)
        }
    }
    
    private func deleteFixup(node x: RBNode) {
        var xTmp = x
        if !x.isRoot && x.color == .black {
            guard var sibling = x.sibling else {
                return
            }
            if sibling.color == .red {
                sibling.color = .black
                if let parentX = x.parent {
                    parentX.color = .red

                    if x.isLeftChild {
                        leftRotate(node: parentX)
                    } else {
                        rightRotate(node: parentX)
                    }
                    if let sibl = x.sibling {
                        sibling = sibl
                    }
                }
            }

            if sibling.leftChild?.color == .black && sibling.rightChild?.color == .black {
                sibling.color = .red
                if let parentX = x.parent {
                    deleteFixup(node: parentX)
                }
            } else {
                if x.isLeftChild && sibling.rightChild?.color == .black {
                    sibling.leftChild?.color = .black
                    sibling.color = .red
                    rightRotate(node: sibling)
                    if let sibl = x.sibling {
                        sibling = sibl
                    }
                } else if x.isRightChild && sibling.leftChild?.color == .black {
                    sibling.rightChild?.color = .black
                    sibling.color = .red
                    leftRotate(node: sibling)
                    if let sibl = x.sibling {
                        sibling = sibl
                    }
                }

                if let parentX = x.parent {
                    sibling.color = parentX.color
                    parentX.color = .black
                    if x.isLeftChild {
                        sibling.rightChild?.color = .black
                        leftRotate(node: parentX)
                    } else {
                        sibling.leftChild?.color = .black
                        rightRotate(node: parentX)
                    }
                    xTmp = root
                }
            }
        }
        xTmp.color = .black
    }
    
    //MARK: - Rotate
    private func leftRotate(node x: RBNode) {
        rotate(node: x, direction: .left)
    }
    private func rightRotate(node x: RBNode) {
        rotate(node: x, direction: .right)
    }
    private func rotate(node x: RBNode, direction: RotationDirection) {
        var nodeY: RBNode? = RBNode()
        
        switch direction {
        case .left:
            nodeY = x.rightChild
            x.rightChild = nodeY?.leftChild
            x.rightChild?.parent = x
        case .right:
            nodeY = x.leftChild
            x.leftChild = nodeY?.rightChild
            x.leftChild?.parent = x
        }
        
        nodeY?.parent = x.parent
        if x.isRoot {
            if let node = nodeY {
                root = node
            }
        } else if x.isLeftChild {
            x.parent?.leftChild = nodeY
        } else if x.isRightChild {
            x.parent?.rightChild = nodeY
        }
        
        switch direction {
        case .left:
            nodeY?.leftChild = x
        case .right:
            nodeY?.rightChild = x
        }
        x.parent = nodeY
    }
    
    //MARK: - toArray
    private func toArray(node: RBTreeNode<T>, nodes: inout [T], time: TimeInterval) {
        guard !node.isNullLeaf else {
            return
        }
        
        if let left = node.leftChild {
            toArray(node: left, nodes: &nodes, time: time)
        }
        
        if let key = node.key {
            nodes.append(key)
            if elementsAmountArray.contains(nodes.count) {
                print("\(Date().timeIntervalSinceReferenceDate-startCalculationTime)")
            }
        }
            
        if let right = node.rightChild {
            toArray(node: right, nodes: &nodes, time: time)
        }
    }
    
    //MARK: - RBTreeNode
    private class RBTreeNode<T: Comparable> {

        typealias RBNode = RBTreeNode<T>
        
        var color: RBTreeColor = .black
        var key: T?
        var leftChild: RBNode?
        var rightChild: RBNode?
        weak var parent: RBNode?
        
        public init(key: T?, leftChild: RBNode?, rightChild: RBNode?, parent: RBNode?) {
            self.key = key
            self.leftChild = leftChild
            self.rightChild = rightChild
            self.parent = parent
            
            self.leftChild?.parent = self
            self.rightChild?.parent = self
        }
        
        public convenience init(key: T?) {
            self.init(key: key, leftChild: RBNode(), rightChild: RBNode(), parent: RBNode())
        }
        
        // For initialising the nullLeaf
        public convenience init() {
            self.init(key: nil, leftChild: nil, rightChild: nil, parent: nil)
            self.color = .black
        }
        
        var isRoot: Bool {
            return parent == nil
        }
        
        var isLeaf: Bool {
            return rightChild == nil && leftChild == nil
        }
        
        var isNullLeaf: Bool {
            return key == nil && isLeaf && color == .black
        }
        
        var isLeftChild: Bool {
            return parent?.leftChild === self
        }
        
        var isRightChild: Bool {
            return parent?.rightChild === self
        }
        
        var grandparent: RBNode? {
            return parent?.parent
        }
        
        var sibling: RBNode? {
            if isLeftChild {
                return parent?.rightChild
            } else {
                return parent?.leftChild
            }
        }
        
        var uncle: RBNode? {
            return parent?.sibling
        }
        
        func getSuccessor() -> RBNode? {
          if let rightChild = self.rightChild {
            if !rightChild.isNullLeaf {
              return rightChild.minimum()
            }
          }
          var currentNode = self
          var parent = currentNode.parent
          while currentNode.isRightChild {
            if let parent = parent {
              currentNode = parent
            }
            parent = currentNode.parent
          }
          return parent
        }
        
        func getPredecessor() -> RBNode? {
          if let leftChild = leftChild, !leftChild.isNullLeaf {
            return leftChild.maximum()
          }
          var currentNode = self
          var parent = currentNode.parent
          while currentNode.isLeftChild {
            if let parent = parent {
              currentNode = parent
            }
            parent = currentNode.parent
          }
          return parent
        }
        
        func minimum() -> RBNode? {
            if let leftChild = leftChild {
                if !leftChild.isNullLeaf {
                    return leftChild.minimum()
                }
                return self
            }
            return self
        }
        
        func maximum() -> RBNode? {
            if let rightChild = rightChild {
                if !rightChild.isNullLeaf {
                    return rightChild.maximum()
                }
                return self
            }
            return self
        }
    }
}
