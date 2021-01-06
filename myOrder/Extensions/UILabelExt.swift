//
//  UILabelExt.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 12/11/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import Foundation
import UIKit

public extension UILabel{
    
    func generateNext(title: String, isEnabled: Bool){
        
        self.text = title
        self.textAlignment = .center
        self.backgroundColor = .selgrosRed
        self.textColor = .selgrosWhite
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.selgrosRed.cgColor
        self.layer.borderWidth = 1
        self.clipsToBounds = true
        
//        layer.masksToBounds = false
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 0.5
//        layer.shadowOffset = CGSize(width: 1, height: 2)
//        layer.shadowRadius = 1
//
//        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
//        layer.shouldRasterize = true
//        self.layer.rasterizationScale = UIScreen.main.scale
        
    }
    func generateAttributedString(fonts:[String], colors:[UIColor], sizes:[CGFloat], texts:[String], alignement:NSTextAlignment){
        
        let mutableAttributedString = NSMutableAttributedString()
        
        let titleParagraphStyle = NSMutableParagraphStyle()
        titleParagraphStyle.alignment = alignement
        titleParagraphStyle.lineBreakMode = .byTruncatingTail
        
        for (idx, text) in texts.enumerated(){
            
            let txt:String = text
            let font:UIFont = UIFont(name:fonts[idx], size:sizes[idx])!
            let color:UIColor = colors[idx]
            let customAtributes = [NSAttributedString.Key.font: font,
                                   NSAttributedString.Key.foregroundColor: color,
                                   NSAttributedString.Key.paragraphStyle: titleParagraphStyle]
            let customAttributStr = NSAttributedString(string: txt, attributes:customAtributes)
            mutableAttributedString.append(customAttributStr)
        }
        
        self.attributedText = mutableAttributedString
    }
}
