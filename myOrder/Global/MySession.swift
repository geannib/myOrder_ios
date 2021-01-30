//
//  MySession.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 12/10/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import Foundation

class MySession {
    
    public static var myCart:MyCart? = nil
    public static var selStoreId:String? = nil
    public static var prodFavs:[FavProductPOJO] = []
    
    public static func saveCart(){
        
        let userDefaults = UserDefaults.standard
        do {
           let data = try JSONEncoder().encode(myCart)
            userDefaults.set(data, forKey: kUDCart)
        } catch {
            print("Error while encoding user data")
        }
        
        
    }
    
    public static func loadCart(){
        
        let userDefaults = UserDefaults.standard
        do {
            let str = UserDefaults.standard.object(forKey: kUDCart) as? Data
            if (str != nil){
                MySession.myCart = try JSONDecoder().decode(MyCart.self, from: str!) ?? MyCart()
            }else{
                 MySession.myCart = MyCart();
            }
            print(MySession.myCart)
        } catch {
            MySession.myCart = MyCart();
            print(error.localizedDescription)
        }
    }
}
