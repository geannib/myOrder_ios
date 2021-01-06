//
//  ViewControllerExt.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 6/25/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    static func mainStoryboard() -> UIStoryboard{
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    static func loadController<T: UIViewController>(_ controllerType: T.Type) -> T {
        let className = String(describing: controllerType)
        return mainStoryboard().instantiateViewController(withIdentifier: className) as! T
    }
    
    static func loadController() -> Self {
        return loadController(self)
    }
    
    /**
     *  Height of status bar + navigation bar (if navigation bar exist)
     */

    var topbarHeight: CGFloat {
    
        var topH:CGFloat = 0.0
        if #available(iOS 13.0, *) {
            topH = (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
                (self.navigationController?.navigationBar.frame.height ?? 0.0)
        } else {
            
            topH = self.navigationController?.navigationBar.frame.size.height ?? 0.0
        }
        
        return topH
    }
    
    func setTitleEx(_ title: String, andImage image: UIImage) {
        let titleLbl = UILabel()
        titleLbl.text = title
        titleLbl.textColor = .selgrosWhite
        titleLbl.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        let imageView = UIImageView(image: image)
        let viewTitle  = UIView()
       viewTitle.translatesAutoresizingMaskIntoConstraints = false
       // add your views and set up all the constraints

       // This is the magic sauce!
       //viewTitle.layoutIfNeeded()
        viewTitle.backgroundColor = .clear
        viewTitle.isOpaque = true
        titleLbl.backgroundColor = .clear
       //viewTitle.sizeToFit()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        viewTitle.addSubview(titleLbl)
        viewTitle.addSubview(imageView)
        let viewsDictionary = ["label": titleLbl, "image": imageView]
        viewTitle.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[label]-3-[image]-|", options: [], metrics: nil, views: viewsDictionary))
        viewTitle.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[image]-|", options: [], metrics: nil, views: viewsDictionary))
        viewTitle.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[label]-|", options: [], metrics: nil, views: viewsDictionary))
        let verticalConstraint = NSLayoutConstraint(item: imageView,
                    attribute: NSLayoutConstraint.Attribute.width,
                    relatedBy: NSLayoutConstraint.Relation.equal,
                    toItem: imageView,
                    attribute: NSLayoutConstraint.Attribute.height,
                    multiplier: 1,
                    constant: 0)
           
        viewTitle.addConstraints([verticalConstraint])
        
       // Now the frame is set (you can print it out)
//       viewTitle.translatesAutoresizingMaskIntoConstraints = true // make nav bar happy
       navigationItem.titleView = viewTitle
        
        
        
        let horizontalConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        
       

    }
}
