//
//  Dictionary+Extension.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 12/8/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import Foundation

func +<Key, Value> (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
    var result = lhs
    rhs.forEach{ result[$0] = $1 }
    return result
}
