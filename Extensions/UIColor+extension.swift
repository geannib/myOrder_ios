//
//  UIColor+extension.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 12/6/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static let selgrosRed = UIColor(hex: 0xE5001F)
    static let selgrosWhite = UIColor(hex: 0xFFFFFF)
    static let selgrosGray = UIColor(hex: 0xDEDEDE)
    static let selgrosBackground = UIColor(hex: 0xF5F5F0)
    
   convenience init(hex: Int) {
       let components = (
           R: CGFloat((hex >> 16) & 0xff) / 255,
           G: CGFloat((hex >> 08) & 0xff) / 255,
           B: CGFloat((hex >> 00) & 0xff) / 255
       )
       self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
   }
    
}
