//
//  RestaurantsResponseData.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 11/16/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//


import UIKit
import ObjectMapper


class CategoryPOJO: Mappable{
    
    
    var id:Int?
    var subcategories:Int?
    var label:String?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.id <- map["store_category.Id", delimiter: ""]
        self.label <- map["store_category.Label", delimiter: ""]
        self.subcategories <- map["subcategories", delimiter: ""]
        
    }
    
}

class CategoriesResponse: RAPIBaseResponse {
    
    
    var categories: [CategoryPOJO]?
    var error:RAPIError?
   
    
    required init?(map: Map) {
        
        super.init(map: map)
        error = nil
        categories = nil
    }
    
    override func mapping(map: Map) {
        
        self.resType <- map["resType", delimiter: ""]
        
        if(resType == "success") {
            
            categories <- map["data", delimiter: ""]
            
        }else
            if(resType == "error"){
                
                error <- map["data", delimiter: ""]
        }
    }
    
    
}

