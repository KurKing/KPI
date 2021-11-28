//
//  main.swift
//  AVLTree
//
//  Created by Oleksiy on 28.03.2021.
//

import Foundation

let tree = AVLTree<Int>()
let elementsCount = 1000000
var elementsAmountArray = [Int]()

for i in 3...6 {
    for j in 1...9 {
        elementsAmountArray.append(j * Int(pow(Double(10), Double(i))))
    }
}

for i in 1...5 {
    elementsAmountArray.append(i * 10000000)
}

print("\(elementsAmountArray)\n")

var startCalculationTime = Date().timeIntervalSinceReferenceDate
for i in 0..<elementsCount {
    tree.insert(value: Int.random(in: -20...20))
    if elementsAmountArray.contains(i+1) {
        print("\(Date().timeIntervalSinceReferenceDate-startCalculationTime)")
    }
}

print("###Search###")
startCalculationTime = Date().timeIntervalSinceReferenceDate
for i in 0..<elementsCount {
    tree.search(value: Int.random(in: -40...40))
    if elementsAmountArray.contains(i+1) {
        print("\(Date().timeIntervalSinceReferenceDate-startCalculationTime)")
    }
}
print("###ToArray###")
startCalculationTime = Date().timeIntervalSinceReferenceDate
var treeArray = tree.toArray(time: startCalculationTime)

print("###Remove###")
startCalculationTime = Date().timeIntervalSinceReferenceDate
for i in 0..<treeArray.count{
    tree.delete(value: treeArray[i])
    if elementsAmountArray.contains(i+1) {
        print("\(Date().timeIntervalSinceReferenceDate-startCalculationTime)")
    }
}
