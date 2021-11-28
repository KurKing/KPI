//
//  SparsedArrayList.swift
//  SparedList
//
//  Created by Oleksiy on 22.03.2021.
//

import Foundation

class SparsedArrayList<T: Comparable> {
    
    private var nodes = [Node<T>]()
    var notNilNodesAmount: Int {
        return nodes.count
    }
        
    func set(x: Int, y: Int, z: Int, value: T){
        let newNode = Node(x: x, y: y, z: z, value: value)
        var index = 0
        
        for node in nodes {
            if newNode.x == node.x && newNode.y == node.y && newNode.z == node.z {
                nodes[index] = newNode
                return
            }
            if newNode.isCoordinatesSmaller(than: node){
                break
            }
            index += 1
        }
        
        nodes.insert(newNode, at: index)
    }
    
    func get(x: Int, y: Int, z: Int) -> T? {
        for node in nodes {
            if x == node.x && y == node.y && z == node.z {
                return node.value
            }
        }
        return nil
    }
    
    func sortNonEmpty() {
        let n = nodes.count
        var gap: Int = n / 2

        while gap > 0 {
            for i in gap..<n {
                let temp = nodes[i].value
                var j = i
                while j >= gap && nodes[j - gap].value > temp{
                    nodes[j].value = nodes[j - gap].value
                    j -= gap
                }
                nodes[j].value = temp
            }
            gap /= 2
        }
            
    }
    
    func toString() -> String {
        var res = ""
        
        for i in nodes {
            res += "\(i.toString())\n"
        }
        
        return res
    }
    
}
