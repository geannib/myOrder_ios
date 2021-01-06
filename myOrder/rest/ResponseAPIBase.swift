//
//  ResponseAPIBase.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 11/16/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import Foundation
import ObjectMapper

class RAPIError: Mappable{
    
    
    var resMessage : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        resMessage <- map["resMessage"]
    }
    
}

class RAPIBaseResponse: Mappable {
    
    
    var hash : String?
    var resType = ""
    
    func mapping(map: Map) {
        
    }
    
    required init?(map: Map) {
        
    }
}
