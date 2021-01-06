//
//  ProductDeailsViewController.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 6/24/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import UIKit

class ProductDeailsViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        self.title = ""
    }
    override func viewWillDisappear(_ animated: Bool) {
         self.title = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
