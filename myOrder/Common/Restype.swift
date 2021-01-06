//
//  Restype.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 11/15/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//
import Foundation

// API response type
enum ResponseType: Int{
    case unknown = 0
    case success
    case failure
    case networkIssue
    case authenticationFailed
    case sessionExpired
}
