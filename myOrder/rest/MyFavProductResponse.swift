//
//  RestaurantsResponseData.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 11/16/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//


import UIKit
import ObjectMapper


class FavProductPOJO: Mappable{
    
    
    var idProd:Int?
    var idList:Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.idList <- map["favorite_list_products.IdFavoriteList", delimiter: ""]
        self.idProd <- map["favorite_list_products.IdStoreProduct", delimiter: ""]
        
    }
    
}

class MyFavProductResponse: RAPIBaseResponse {
    
    
    var prodFavs: [FavProductPOJO]?
    var error:RAPIError?
   
    
    required init?(map: Map) {
        
        super.init(map: map)
        error = nil
        prodFavs = nil
    }
    
    override func mapping(map: Map) {
        
        self.resType <- map["resType", delimiter: ""]
        
        if(resType == "success") {
            
            prodFavs <- map["data", delimiter: ""]
            
        }else
            if(resType == "error"){
                
                error <- map["data", delimiter: ""]
        }
    }
    
    
}

