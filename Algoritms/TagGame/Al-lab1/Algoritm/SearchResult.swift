//
//  SearchResult.swift
//  Al-lab1
//
//  Created by Oleksiy on 22.09.2021.
//

import Foundation

typealias SearchResult = Result<SuccessSearchData, FailureReason>

struct SuccessSearchData {
    let time: TimeInterval?
    let depth: Int?
    let closedStates: Int?
    let openedStates: Int?
    let initialState: [[Int]]?
    let currentState: [[Int]]?
}

enum FailureReason: Error {
    case timeLimitReached(depth: Int?, closedStates: Int?, openedStates: Int?, initialState: [[Int]]?)
    case noResult(closedStates: Int?, openedStates: Int?, initialState: [[Int]]?)
    case recusriveDepthLimitReached
    case impasse
}

func print(_ searchResult: SearchResult) {
    var stringToPrint = ""
    switch searchResult {
    case .success(let data):
        stringToPrint += "\nResult found!"
        if let time = data.time { stringToPrint += "\nTime:\(time)s" }
        if let depth = data.depth { stringToPrint += "\nDepth:\(depth)" }
        if let openedStates = data.openedStates { stringToPrint += "\nOpened states:\(openedStates)" }
        if let closedStates = data.closedStates { stringToPrint += "\nClosed states:\(closedStates)" }
        if let initialState = data.initialState { stringToPrint += "\nInitial state:\(initialState)" }
        break
    case .failure(let reason):
        stringToPrint += "\nResult not found!"
        switch reason {
        case .timeLimitReached(depth: let depth, closedStates: let closedStates, openedStates: let openedStates, initialState: let initialState):
            stringToPrint += " Reason: time limit reached"
            if let depth = depth { stringToPrint += "\nDepth:\(depth)" }
            if let openedStates = openedStates { stringToPrint += "\nOpened states:\(openedStates)" }
            if let closedStates = closedStates { stringToPrint += "\nClosed states:\(closedStates)" }
            if let initialState = initialState { stringToPrint += "\nInitial state:\(initialState)" }
        case .noResult(closedStates: let closedStates, openedStates: let openedStates, initialState: let initialState):
            stringToPrint += " Reason: no result"
            if let openedStates = openedStates { stringToPrint += "\nOpened states:\(openedStates)" }
            if let closedStates = closedStates { stringToPrint += "\nClosed states:\(closedStates)" }
            if let initialState = initialState { stringToPrint += "\nInitial state:\(initialState)" }
        default:
            stringToPrint += " Reason: unknown error!"
        }
        break
    }
    print(stringToPrint)
}
