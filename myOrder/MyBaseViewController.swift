//
//  MyBaseViewController.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 12/27/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import Foundation
import UIKit
import BarcodeScanner

class MyBaseViewController: UIViewController{
    
    var navCos: UIBarButtonItem = UIBarButtonItem()
    var navHeart: UIBarButtonItem = UIBarButtonItem()
    var navCode: UIBarButtonItem = UIBarButtonItem()
    var navSearch: UIBarButtonItem = UIBarButtonItem()
    override func viewDidLoad() {
            navCos = UIBarButtonItem(target: self,
                      action: #selector(basketTapped),
                      imgName: "cos_navigare",
                      hasBadge: true)
            navHeart =  UIBarButtonItem(target: self,
                     action: #selector(basketTapped),
                     imgName: "heart_navigare",
                     hasBadge: true)
            navCode =  UIBarButtonItem(target: self,
                     action: #selector(barCodTapped),
                     imgName: "code_navigare",
                     hasBadge: false)
            navSearch = UIBarButtonItem(target: self,
                     action: #selector(basketTapped),
                     imgName: "search_navigare",
                     hasBadge: false)
        
             
             self.navigationItem.rightBarButtonItems = [navCos,
                                                        navHeart,
                                                        navCode,
                                                        navSearch]
             

             
    }
    
      @objc func barCodTapped(sender: AnyObject) {
         let barcodeScanner:MyBarcodeScannerVision = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyBarcodeScannerVision") as! MyBarcodeScannerVision
                
         present(barcodeScanner, animated: true, completion: nil)
     }

    
     @objc func basketTapped(sender: AnyObject) {
         let cosVC:CosViewController = UIStoryboard(name: "Finalizare", bundle: nil).instantiateViewController(withIdentifier: "CosViewController") as! CosViewController
         self.navigationController?.pushViewController(cosVC, animated: true)
         
     }
}
