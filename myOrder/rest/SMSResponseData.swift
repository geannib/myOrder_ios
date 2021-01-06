//
//  SMSResponseData.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 12/30/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import Foundation

//
//  RestaurantsResponseData.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 11/16/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//


import UIKit
import ObjectMapper

class SMSResponseData: RAPIBaseResponse {
    
    
    var code: Bool?
    var error:RAPIError?
   
    
    required init?(map: Map) {
        
        super.init(map: map)
        error = nil
        code = false
    }
    
    override func mapping(map: Map) {
        
        self.resType <- map["resType", delimiter: ""]
        
        if(resType == "success") {
            
            code <- map["data", delimiter: ""]
            
        }else
            if(resType == "error"){
                
                error <- map["data", delimiter: ""]
        }
    }
    
    
}

