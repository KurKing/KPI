//
//  Tests.swift
//  Tests
//
//  Created by Oleksiy on 06.02.2021.
//

import XCTest

class Tests: XCTestCase {
    
    private func getList() -> DoubleLinkedList<Int>{
        let list = DoubleLinkedList<Int>()

        list.insert(value: 1)
        list.insert(value: 2)
        list.insert(value: 3)

        list.insert(value: 4, as: .first)
        list.insert(value: 5, as: .first)
        list.insert(value: 6, as: .first)

        list.insert(value: 8, at: 2)
        list.insert(value: 9, at: 2)
        list.insert(value: 10, at: 2)

        list.insert(value: 11, at: 7)
        list.insert(value: 12, at: 7)
        list.insert(value: 13, at: 7)
        
        return list
    }

    func testInsertion(){
        
        XCTAssertEqual(getList().toArray(), [6, 5, 10, 9, 8, 4, 1, 13, 12, 11, 2, 3])
        
    }
    
    func testReplace(){
        
        let list = getList()
        list.replace(at: 0, with: 14)
        list.replace(at: list.count, with: 14)
        list.replace(at: 5, with: 14)
        
        XCTAssertEqual(list.toArray(), [14, 5, 10, 9, 8, 14, 1, 13, 12, 11, 2, 14])
        
    }
    
    func testRemove(){
        let list = DoubleLinkedList<Int>()
        
        for i in 0...5 {
            list.insert(value: i)
        }
        
        list.remove(at: 3)
        XCTAssertEqual(list.toArray(), [0,1,2,4,5])
        
        list.remove(.first)
        XCTAssertEqual(list.toArray(), [1,2,4,5])
        
        list.remove(.last)
        XCTAssertEqual(list.toArray(), [1,2,4])
    }
    
    func testIndex(){
        let list = DoubleLinkedList<Int>()
        
        for i in 0...5 {
            list.insert(value: i)
        }
        
        XCTAssertEqual(list.index(of: 1), 1)
        XCTAssertEqual(list.index(of: 3), 3)
        XCTAssertEqual(list.index(of: 10), nil)
    }

}
