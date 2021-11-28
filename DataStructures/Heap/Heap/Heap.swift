//
//  Heap.swift
//  Heap
//
//  Created by Oleksiy on 15.04.2021.
//

import Foundation

struct Heap<T: Comparable> {
    private var nodes = [T]()
    
    var isEmpty: Bool {
      return nodes.isEmpty
    }
    
    var count: Int {
      return nodes.count
    }
    
    var toArray: [T] {
        return nodes
    }
    
    //MARK: - Public
    mutating func insert(_ value: T) {
      nodes.append(value)
      shiftUp(nodes.count - 1)
    }
    
    mutating func remove(at index: Int) {
      guard index < nodes.count else { return }
      
      let size = nodes.count - 1
      if index != size {
        nodes.swapAt(index, size)
        shiftDown(from: index, until: size)
        shiftUp(index)
      }
      nodes.removeLast()
    }
    
    func index(of value: T) -> Int? {
        return nodes.firstIndex(where: { $0 == value })
    }

    //MARK: - Private
    private mutating func shiftUp(_ index: Int) {
      var childIndex = index
      let child = nodes[childIndex]
      var parentIndex = self.parentIndex(ofIndex: childIndex)
      
      while childIndex > 0 && child < nodes[parentIndex] {
        nodes[childIndex] = nodes[parentIndex]
        childIndex = parentIndex
        parentIndex = self.parentIndex(ofIndex: childIndex)
      }
      
      nodes[childIndex] = child
    }
    
    private mutating func shiftDown(_ index: Int) {
      shiftDown(from: index, until: nodes.count)
    }
    
    private mutating func shiftDown(from index: Int, until endIndex: Int) {
      let leftChildIndex = self.leftChildIndex(ofIndex: index)
      let rightChildIndex = leftChildIndex + 1
      

      var first = index
      if leftChildIndex < endIndex && nodes[leftChildIndex] < nodes[first] {
        first = leftChildIndex
      }
      if rightChildIndex < endIndex && nodes[rightChildIndex] < nodes[first] {
        first = rightChildIndex
      }
      if first == index { return }
      
      nodes.swapAt(index, first)
      shiftDown(from: first, until: endIndex)
    }
    
    //MARK: - Index count
    private func parentIndex(ofIndex i: Int) -> Int {
      return (i - 1) / 2
    }

    private func leftChildIndex(ofIndex i: Int) -> Int {
      return 2*i + 1
    }

    private func rightChildIndex(ofIndex i: Int) -> Int {
      return 2*i + 2
    }
    
}
