//
//  NewAddressViewController.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 1/11/21.
//  Copyright © 2021 Geanni Barbulescu. All rights reserved.
//

import UIKit

class NewAddressViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var labelNext: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageLocation: UIImageView!
    @IBOutlet weak var tableNewAddress: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableNewAddress.dataSource = self
        tableNewAddress.delegate = self
        
        makeup()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Adresa"
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }

    func makeup(){
        
        tableNewAddress.separatorStyle = .none
        
        labelTitle.generateAttributedString(fonts: ["Roboto-Regular"],
        colors: [.gray],
        sizes: [20],
        texts: ["Alegeti locatia si apoi corecati datele daca este cazul "],
        alignement: .left)
        
        labelNext.generateNext(title: "SALVEAZA ADRESA", isEnabled: true)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 6
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        let addressCell:NewAddressTableViewCell = tableView.dequeueReusableCell(withIdentifier: "NewAddressTableViewCell", for: indexPath) as! NewAddressTableViewCell
              
           
        addressCell.position = indexPath.row
        return addressCell
       }

}
