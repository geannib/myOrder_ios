//
//  AdressPopupViewController.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 1/10/21.
//  Copyright © 2021 Geanni Barbulescu. All rights reserved.
//

import UIKit

protocol AdresaProtocol: NSObjectProtocol {
    
    func addNewAddress()
    
}
class AdressPopupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    

    @IBOutlet weak var viewMiddle: UIView!
    @IBOutlet weak var labelNext: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var tableAddresses: UITableView!
    @IBOutlet weak var viewBackground: UIView!
    weak var adresaProtocol:AdresaProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableAddresses.dataSource = self
        tableAddresses.delegate = self
        
    
        makeup()
        addEvents()
        // Do any additional setup after loading the view.
    }
    
    @objc func nextTapped(_ sender:UITapGestureRecognizer){
        
        self.adresaProtocol?.addNewAddress()
    }
    
    func addEvents(){
        labelNext.isUserInteractionEnabled = true
         let tapNext = UITapGestureRecognizer(target: self, action:  #selector (self.nextTapped (_:)))
        tapNext.numberOfTapsRequired = 1
        labelNext.addGestureRecognizer(tapNext)
    }
     func makeup(){
           self.view.backgroundColor = .clear
           self.view.isOpaque = false
           
           viewBackground.backgroundColor = .black
           viewBackground.isOpaque = true
           viewBackground.alpha = 0.4
           
           viewMiddle.backgroundColor = .white
           labelTitle.generateAttributedString(fonts: ["Roboto-Bold"],
           colors: [.black],
           sizes: [20],
           texts: ["Selectati o adresa "],
           alignement: .center)
           
           labelNext.generateNext(title: "ADAUGA ADRESA", isEnabled: true)
       
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellStore:AddressTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AddressTableViewCell", for: indexPath) as! AddressTableViewCell
               
            
               return cellStore
    }

}
