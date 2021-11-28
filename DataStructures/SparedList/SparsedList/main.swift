//
//  main.swift
//  SparsedList
//
//  Created by Oleksiy on 22.03.2021.
//

import Foundation

let list = SparsedArrayList<Int>()

list.set(x: 0, y: 0, z: 0, value: 1)
list.set(x: 0, y: 0, z: 1, value: 2)
list.set(x: 1, y: 0, z: 2, value: 3)
list.set(x: 0, y: 2, z: 3, value: 4)

print(list.toString())

list.set(x: 0, y: 0, z: 0, value: 10)
list.set(x: 1, y: 0, z: 2, value: 10)

print(list.toString())
print("Not nil nodes amount: \(list.notNilNodesAmount)\n")

list.sortNonEmpty()

print(list.toString())

print(list.get(x: 0, y: 0, z: 0))
print(list.get(x: -1, y: -1, z: -1))
