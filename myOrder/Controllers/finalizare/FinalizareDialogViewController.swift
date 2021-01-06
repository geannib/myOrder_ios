//
//  FinalizareDialogViewController.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 1/6/21.
//  Copyright © 2021 Geanni Barbulescu. All rights reserved.
//

import UIKit

class FinalizareDialogViewController: UIViewController {

    @IBOutlet weak var labelNext: UILabel!
    @IBOutlet weak var labelTtitle: UILabel!
    @IBOutlet weak var imageCheckmark: UIImageView!
    @IBOutlet weak var viewMiddle: UIView!
    @IBOutlet weak var viewBackground: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        makeup()
        // Do any additional setup after loading the view.
    }
    

    func makeup(){
        self.view.backgroundColor = .clear
        self.view.isOpaque = false
        
        viewBackground.backgroundColor = .black
        viewBackground.isOpaque = true
        viewBackground.alpha = 0.4
        
        viewMiddle.backgroundColor = .white
        labelTtitle.generateAttributedString(fonts: ["Roboto-Bold"],
        colors: [.black],
        sizes: [20],
        texts: ["Comanda a fost plasata cu success "],
        alignement: .center)
        
        labelNext.generateNext(title: "GATA", isEnabled: true)
    
    }

}
