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
    
    func setTitleEx(_ title: String, andImage image: UIImage, target: Any, _ selector: Selector) {
        let titleLbl = UILabel()
        titleLbl.text = title
        titleLbl.textColor = .selgrosWhite
        titleLbl.generateAttributedString(fonts: ["Roboto-Bold"],
        colors: [.white],
        sizes: [20],
        texts: [title],
        alignement: .center)
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
        var frm = viewTitle.frame
        frm = CGRect(origin: frm.origin, size: CGSize(width: 30, height: frm.size.height))
        viewTitle.frame = frm
        let viewsDictionary = ["label": titleLbl, "image": imageView]
        
        // Horizontal
        viewTitle.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-[label]-3-[image]-|",
            options: [],
            metrics: nil,
            views: viewsDictionary))
        
        // Vertical
        viewTitle.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-[image]-|",
            options: [],
            metrics: nil,
            views: viewsDictionary))
        
        viewTitle.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-[label]-|",
            options: [],
            metrics: nil,
            views: viewsDictionary))
        
           
        NSLayoutConstraint.activate([
            viewTitle.widthAnchor.constraint(equalToConstant: view.frame.width * (2.7/4.0)),
                       ])
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: topbarHeight),
            imageView.heightAnchor.constraint(equalToConstant: topbarHeight),
                   ])
        //viewTitle.addConstraints([verticalConstraint])
        
        let horizontalConstraint = NSLayoutConstraint(item:titleLbl,
              attribute:.width,
              relatedBy:.greaterThanOrEqual,
              toItem:viewTitle,
              attribute:.width,
              multiplier:0.4,
              constant:0);
              horizontalConstraint.isActive = true
       navigationItem.titleView = viewTitle
        
        viewTitle.isUserInteractionEnabled = true
        let tapCombo = UITapGestureRecognizer(target: target, action: selector)
        tapCombo.numberOfTapsRequired = 1
        viewTitle.addGestureRecognizer(tapCombo)
        
       

    }
    
}

