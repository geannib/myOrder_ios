//
//  MyCart.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 12/10/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import Foundation

class MyCart: Codable {
    var products:[MyBuyProduct] = []
    
    
    func addProduct(prod:MyBuyProduct){
        
        var found = false
        for p in products {
            
            if (p.prodId == prod.prodId){
                p.quantity = prod.quantity
               found = true
                break
            }
        }
        
        if (found == true){
            
        }else{
            products.append(prod)
        }
    }
    
    func getProd(prodId:Int) -> MyBuyProduct?{
        
        for p in products {
            
            if (p.prodId == prodId){
            
               return p
            }
        }
        
        return nil
    }
    func removeProduct(prodId:Int){
        
        var idx = 0
        
       for p in products {
            
            if (p.prodId == prodId){
                products.remove(at: idx)
                break;
            }
        idx += 1
        }
    }
    
    func getProducts() -> [MyBuyProduct] {
        return products;
    }
}
