//
//  RestaurantsResponseData.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 11/16/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//


import UIKit
import ObjectMapper


class ProductPOJO: Mappable{
    
    var id:Int?;
    var CodeEAN:Int?;
    var TVA:Double?;
    var PackageUnits:Double?;
    var MaxSellingQuantity:Double?;
    var name:String?;
    var description:String?;
    var price:Double?
    var image:String?
    var idstoreproductsubcategory:Double?;
    var categoryLabel:String?;
    var packageMode:Int?;
    var categoryId:Int?;
    var storeId:Int?;
    var storeName:String?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {

        self.id <- map["store_product.Id", delimiter: ""]
        self.CodeEAN <- map["store_product.CodeEAN", delimiter: ""]
        self.TVA <- map["store_product.TVA", delimiter: ""]
        self.PackageUnits <- map["store_product.PackageUnits", delimiter: ""]
        self.MaxSellingQuantity <- map["store_product.MaxSellingQuantity", delimiter: ""]
        self.name <- map["store_product.Name", delimiter: ""]
        self.description <- map["store_product.Description", delimiter: ""]
        self.price <- map["store_product.Price", delimiter: ""]
        self.image <- map["store_product.Image", delimiter: ""]
        self.idstoreproductsubcategory <- map["store_product.Idstoreproductsubcategory", delimiter: ""]
        self.categoryLabel <- map["store_category.Label", delimiter: ""]
        self.packageMode <- map["store_product.PackageMode", delimiter: ""]
        self.categoryId <- map["store_category.Id", delimiter: ""]
        self.storeId <- map["store.Id", delimiter: ""]
        self.storeName <- map["store.Name", delimiter: ""]
           
    }
    
}

class ProductsResponse: RAPIBaseResponse {
    
    
    var products: [ProductPOJO]?
    var error:RAPIError?
   
    
    required init?(map: Map) {
        
        super.init(map: map)
        error = nil
        products = nil
    }
    
    override func mapping(map: Map) {
        
        self.resType <- map["resType", delimiter: ""]
        
        if(resType == "success") {
            
            products <- map["data", delimiter: ""]
            
        }else
            if(resType == "error"){
                
                error <- map["data", delimiter: ""]
        }
    }
    
    
}

