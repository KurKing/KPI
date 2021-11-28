//
//  main.swift
//  DoubleLinkedList
//
//  Created by Oleksiy on 05.02.2021.
//

import Foundation

let list = DoubleLinkedList<Int>()

print("start")

let startCalculationTime = Date().timeIntervalSinceReferenceDate

list.insert(value: 0)
list.insert(value: 0)
list.insert(value: 0)
for _ in 0..<10000 {
    list.insert(value: 0, at: Int.random(in: 0...list.count))
}

let endCalculationTime = Date().timeIntervalSinceReferenceDate
print(endCalculationTime-startCalculationTime)
print(list.count)

let startCalculationTime2 = Date().timeIntervalSinceReferenceDate

for _ in 0..<10000 {
    list.remove(at: Int.random(in: 0..<list.count))
}

let endCalculationTime2 = Date().timeIntervalSinceReferenceDate
print(endCalculationTime2-startCalculationTime2)
