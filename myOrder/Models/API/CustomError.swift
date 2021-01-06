//
//  CustomError.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 11/15/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import Foundation
class CustomError: Error {
    
    let errorMessage: String!
    let errorCode: String!
    
    init(message : String, code: String){
        
        self.errorMessage = message
        self.errorCode = code
        
    }
}
