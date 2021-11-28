//
//  AStar.swift
//  Al-lab1
//
//  Created by Oleksii Kurkin on 21.09.2021.
//

import Foundation

class AStar {
    
    let root: Node
    var openStates: [Node]
    var closedStates: [Matrix]
    var timeStart: TimeInterval!
    
    init(root: Node = .init(matrix: .random)) {
        self.root = root
        openStates = []
        closedStates = []
    }
    
    private func aStar(node: Node) -> SearchResult {
        print("\(node.matrix.matrix), closed states: \(closedStates.count), open states: \(openStates.count), depth: \(node.depth)")
        closedStates.append(node.matrix)
        
        if node.isFinish {
            return .success(.init(time: Date().timeIntervalSinceReferenceDate - timeStart, depth: node.depth, closedStates: closedStates.count, openedStates: openStates.count, initialState: root.matrix.matrix, currentState: node.matrix.matrix))
        }
        
        if Date().timeIntervalSinceReferenceDate - timeStart > 1800 {
            return .failure(.timeLimitReached(depth: node.depth, closedStates: closedStates.count, openedStates: openStates.count, initialState: root.matrix.matrix))
        }
        
        if node.depth > 4000 {
            return .failure(.recusriveDepthLimitReached)
        }
        
        let children = node.children
            .compactMap { closedStates.contains($0.matrix) ? nil : $0 }
        
        if children.count > 0 {
            openStates.append(contentsOf: children)
        }
        
        return .failure(.impasse)
    }
}

// MARK: - Runable
extension AStar: Runable {

    func run() -> SearchResult {
        timeStart = Date().timeIntervalSinceReferenceDate
        
        openStates.append(root)
        while openStates.count > 0 {
            let minNode = openStates.min(by: { $0.matrix.h1 < $1.matrix.h1})!
            let result = aStar(node: openStates.remove(at: openStates.firstIndex(where: { $0.matrix == minNode.matrix })!))
            switch result {
            case .success:
                return result
            case .failure(let reason):
                switch reason {
                case .timeLimitReached:
                    return result
                default:
                    continue
                }
            }
        }
        return .failure(.noResult(closedStates: closedStates.count, openedStates: openStates.count, initialState: root.matrix.matrix))
    }
}
