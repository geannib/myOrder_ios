//
//  RestaurantsResponseData.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 11/16/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//


import UIKit
import ObjectMapper




class StorePOJO: Mappable{
    
    
    var id:Int?
    var name:String?
    var label:String?
    var addrId:Int?
    var description:String?
    var orderFee:String?
    var deliveryTime:Int?
    var minimumOrder:String?
    var exceptionClose:Bool?
    var openHour:String?
    var closeHour:String?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.id <- map["store.Id", delimiter: ""]
        self.name <- map["store.Name", delimiter: ""]
        self.description <- map["store.Description", delimiter: ""]
        self.orderFee <- map["store.OrderFee", delimiter: ""]
        self.deliveryTime <- map["store.DeliveryTime", delimiter: ""]
        self.minimumOrder <- map["store.MinimumOrder", delimiter: ""]
        self.label <- map["store_type.Label", delimiter: ""]
        self.addrId <- map["store_address.IdAddress", delimiter: ""]
        self.exceptionClose <- map["store_timetable_exception.Closed", delimiter: ""]
        self.openHour <- map["store_timetable_exception.Start", delimiter: ""]
        self.closeHour <- map["store_timetable_exception.End", delimiter: ""]
        
    }
    
}

class RRestaurantsResponse: RAPIBaseResponse {
    
    
    var restaurants: [StorePOJO]?
    var error:RAPIError?
   
    
    required init?(map: Map) {
        
        super.init(map: map)
        error = nil
        restaurants = nil
    }
    
    override func mapping(map: Map) {
        
        self.resType <- map["resType", delimiter: ""]
        
        if(resType == "success") {
            
            restaurants <- map["data", delimiter: ""]
            
        }else
            if(resType == "error"){
                
                error <- map["data", delimiter: ""]
        }
    }
    
    
}

