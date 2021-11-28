//
//  LDFS.swift
//  Al-lab1
//
//  Created by Oleksii Kurkin on 21.09.2021.
//

import Foundation

class LDFS {

    let root: Node
    var closedStates: [Matrix]
    var timeStart: TimeInterval!

    init(root: Node = .init(matrix: .random)) {
        self.root = root
        closedStates = []
    }

    private func recursiveSearch(node: Node) -> SearchResult {
        print("\(node.matrix.matrix), depth: \(node.depth), closed states count: \(closedStates.count)")
        
        closedStates.append(node.matrix)
        if node.isFinish {
            return .success(.init(time: Date().timeIntervalSinceReferenceDate - timeStart, depth: node.depth, closedStates: closedStates.count, openedStates: nil, initialState: root.matrix.matrix, currentState: node.matrix.matrix))
        }
        
        if Date().timeIntervalSinceReferenceDate - timeStart > 1800 {
            return .failure(.timeLimitReached(depth: node.depth, closedStates: closedStates.count, openedStates: nil, initialState: root.matrix.matrix))
        }
        
        if node.depth > 4000 {
            return .failure(.recusriveDepthLimitReached)
        }
        
        let children = node.children
            .compactMap { closedStates.contains($0.matrix) ? nil : $0 }
//            .sorted(by: { $0.matrix.h1 < $1.matrix.h1})
        
        for i in children {
            let result = recursiveSearch(node: i)
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
        
        return .failure(.impasse)
    }
}

// MARK: - Runable
extension LDFS: Runable {
    
    func run() -> SearchResult {
        timeStart = Date().timeIntervalSinceReferenceDate
        let result = recursiveSearch(node: root)
        switch result {
        case .success:
            return result
        case .failure(let reason):
            switch reason {
            case .timeLimitReached:
                return result
            default:
                return .failure(.noResult(closedStates: closedStates.count, openedStates: nil, initialState: root.matrix.matrix))
            }
        }
    }
}
