

//
//  WebWrapper.swift
//  myOrder
//
//  Created by Apple on 16/10/2018.
//  Copyright © 2018 Manu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper

class WebWrapper: NSObject {

    static let shared = WebWrapper()
    
 
    
    
    func callAPI(reqType: String,
                 parameters: [String: String],
                 methodType: HTTPMethod = .post,
                 showLoader: Bool = true,
                 completion:@escaping ( _  resType: ResponseType?,
                                        _ response : String?,
                                        _ error:CustomError?) -> ()){
        

        
        var hashStr = ""
       
        let jsonData = try! JSONSerialization.data(withJSONObject: parameters)
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
        
        let headers : [String:String] = [:]
           // "Content-Type": "application/x-www-form-urlencoded"
//        ]
        
        print("dataParams \(parameters)")
        print("URL \(API_GET_STORES)")
        

        AF.request(reqType, parameters: parameters).response { response in
        debugPrint(response)
        
            if(response.error != nil){
                print("call error: \(String(describing: response.error?.localizedDescription))")
            }
            let jsonRes = try! JSON(data: response.data!)
            
            let str = jsonRes.rawString()!
            
             completion(.success , str , nil)


            if let status = response.response?.statusCode {
                
                if Int(status) == 200 {
                    
                   
                }
                else{
                    let error = CustomError(message: NSLocalizedString("kUnknownError", comment:""), code: "")
                    completion(.failure , nil , error)
                }
            }
            else{
                let error = CustomError(message: NSLocalizedString("kUnknownError", comment:""), code: "")
                completion(.failure , nil , error)
            }
        }
    }
}
