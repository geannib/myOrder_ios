//
//  BadgeBarButtonItem.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 12/26/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import Foundation

import UIKit

typealias CompletionHandler = (_ sender:AnyObject) -> Void

extension UIBarButtonItem {
    
    func setBadgeCount( cnt: Int){
        
        guard let lblBagde:UILabel = self.customView?.viewWithTag(789) as? UILabel else {return}
        lblBagde.text = String(cnt)
        lblBagde.isHidden = (cnt == 0)
        
    }
    convenience init(target: AnyObject, action: Selector, imgName: String, hasBadge: Bool){
        
        let navBarHeight = (target as! UIViewController).topbarHeight * (3.0/5.0);
        let labelH = navBarHeight * (1.0/2.0)
        
        // badge label
       let lblBadge = UILabel(frame: CGRect(x: navBarHeight - labelH , y: 0, width: labelH, height: labelH))
       lblBadge.layer.borderColor = UIColor.clear.cgColor
       lblBadge.layer.borderWidth = 2
       lblBadge.layer.cornerRadius = lblBadge.bounds.size.height / 2
       lblBadge.textAlignment = .center
       lblBadge.layer.masksToBounds = true
       lblBadge.font = UIFont(name: "Roboto-Medium", size: labelH - 3)
       lblBadge.textColor = .black
       lblBadge.backgroundColor = .selgrosWhite
       lblBadge.text = ""
       lblBadge.isUserInteractionEnabled = false
        lblBadge.tag = 789
        lblBadge.isHidden = true
       
        // cos
        let menuBtnCos = UIButton(type: .custom)
        menuBtnCos.frame = CGRect(x: 0.0, y: 0.0, width: navBarHeight, height: navBarHeight)
        menuBtnCos.setImage(UIImage(named:imgName), for: .normal)
        menuBtnCos.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
        
        if(hasBadge == true){
              menuBtnCos.addSubview(lblBadge)
        }

        self.init()

        self.customView = menuBtnCos
        let currWidth = self.customView?.widthAnchor.constraint(equalToConstant: navBarHeight)
        let currHeight = self.customView?.heightAnchor.constraint(equalToConstant: navBarHeight)

        currWidth?.isActive = true
        currHeight?.isActive = true

     
    }



    static func nextBtn(target: AnyObject, action: Selector) -> UIBarButtonItem {
        let title = "Next"
        return button(title: title, target: target, action: action)
    }

    private static func button(title: String, target: AnyObject, action: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(title: title, style: .done, target: target, action: action)
    }

}



