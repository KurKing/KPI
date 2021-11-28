//
//  main.swift
//  Heap
//
//  Created by Oleksiy on 15.04.2021.
//

import Foundation

var heap = Heap<Int>()
let elementsCount = 1000000

var startCalculationTime = Date().timeIntervalSinceReferenceDate
for i in (0..<elementsCount).reversed() {
    heap.insert(i)
}
//for i in 0..<elementsCount {
//    heap.insert(i)
//}
//for _ in 0..<elementsCount {
//    heap.insert(Int.random(in: -20...20))
//}
print("Add:")
var endCalculationTime = Date().timeIntervalSinceReferenceDate
print("\(String(format: "%.2f", endCalculationTime-startCalculationTime)) sec")

startCalculationTime = Date().timeIntervalSinceReferenceDate
for _ in 0..<heap.count {
    heap.remove(at: Int.random(in: 0..<heap.count))
}
print("\nRemove:")
endCalculationTime = Date().timeIntervalSinceReferenceDate
print("\(String(format: "%.2f", endCalculationTime-startCalculationTime)) sec")
