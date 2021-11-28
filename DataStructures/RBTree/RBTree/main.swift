//
//  main.swift
//  RBTree
//
//  Created by Oleksiy on 28.03.2021.
//

import Foundation

let tree = RedBlackTree<Int>()
let elementsCount = 10000000
print("hello")
var keyArray = (0..<elementsCount).shuffled()
print("bye")
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
    tree.insert(key: keyArray[i])
    if elementsAmountArray.contains(i+1) {
        print("\(Date().timeIntervalSinceReferenceDate-startCalculationTime)")
    }
}

print("###Search###")
startCalculationTime = Date().timeIntervalSinceReferenceDate
for i in 0..<elementsCount {
    tree.seachValue(input: Int.random(in: -elementsCount...elementsCount))
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
    tree.delete(key: treeArray[i])
    if elementsAmountArray.contains(i+1) {
        print("\(Date().timeIntervalSinceReferenceDate-startCalculationTime)")
    }
}
