//
//  main.swift
//  Al-lab1
//
//  Created by Oleksiy on 20.09.2021.
//

import Foundation

let algoritm = LDFS(root: Node(matrix: [[0,6,3],[1,5,2],[7,4,8]]))
//let algoritm = LDFS()

//let algoritm = AStar(root: Node(matrix: [[3,8,1],[0,4,7],[5,6,2]]))
//let algoritm = AStar()


print(algoritm.run())
