//
//  Helpers.swift
//  ClobberGame
//
//  Created by Oleksiy on 04.12.2021.
//

import Foundation

func with<T>(_ object: T, setup:((T)->())) -> T {
    setup(object)
    return object
}
