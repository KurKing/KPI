//
//  main.swift
//  Tree
//
//  Created by Oleksiy on 15.01.2021.
//

import Foundation

//var elementsAmountArray = [Int]()
//
//print("BST")
//for i in 4...6 {
//    for j in 1...9 {
//        elementsAmountArray.append(j * Int(pow(Double(10), Double(i))))
//    }
//}

var elementsAmountArray = [8000,9000,20000]

print(elementsAmountArray)

for elementsCount in elementsAmountArray {
    let tree = Tree<Int>()
    var startCalculationTime = Date().timeIntervalSinceReferenceDate
    for _ in 0..<elementsCount {
        tree.add(Int.random(in: -20...20))
    }
    var endCalculationTime = Date().timeIntervalSinceReferenceDate
    print("Add \(elementsCount) elements: \(endCalculationTime-startCalculationTime) seconds")

    startCalculationTime = Date().timeIntervalSinceReferenceDate
    for _ in 0..<elementsCount {
        tree.get(value: Int.random(in: -40...40))
    }
    endCalculationTime = Date().timeIntervalSinceReferenceDate
    print("Search \(elementsCount) elements: \(endCalculationTime-startCalculationTime) seconds")


    startCalculationTime = Date().timeIntervalSinceReferenceDate
    let treeArray = tree.toArray()
    endCalculationTime = Date().timeIntervalSinceReferenceDate
    print("ToArray \(elementsCount) elements: \(endCalculationTime-startCalculationTime) seconds")

    startCalculationTime = Date().timeIntervalSinceReferenceDate
    for i in treeArray{
        tree.removeNode(with: i)
    }
    endCalculationTime = Date().timeIntervalSinceReferenceDate
    print("Remove \(elementsCount) elements: \(endCalculationTime-startCalculationTime) seconds")

//    print("\n\t### WORST CASE ###")

//    var startCalculationTime = Date().timeIntervalSinceReferenceDate
//    for i in 0..<elementsCount {
//        tree.add(i)
//    }
//    var endCalculationTime = Date().timeIntervalSinceReferenceDate
//    print("\tAdd \(elementsCount) elements: \(endCalculationTime-startCalculationTime) seconds")
//
//    startCalculationTime = Date().timeIntervalSinceReferenceDate
//    for _ in 0..<elementsCount {
//        tree.get(value: Int.random(in: -elementsCount...elementsCount))
//    }
//    endCalculationTime = Date().timeIntervalSinceReferenceDate
//    print("\tSearch \(elementsCount) elements: \(endCalculationTime-startCalculationTime) seconds")
//
//    startCalculationTime = Date().timeIntervalSinceReferenceDate
//    for i in (0..<elementsCount).reversed() {
//        tree.removeNode(with: i)
//    }
//    endCalculationTime = Date().timeIntervalSinceReferenceDate
//    print("\tRemove \(elementsCount) elements: \(endCalculationTime-startCalculationTime) seconds")

    print("------------------------------------")
}

