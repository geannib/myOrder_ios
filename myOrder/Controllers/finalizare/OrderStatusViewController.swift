//
//  OrderStatusViewController.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 12/31/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import UIKit

class OrderStatusViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableStatus: UITableView!
    @IBOutlet weak var labelTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        makeup()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Order status"
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    func makeup(){
        tableStatus.separatorStyle = .none
        tableStatus.backgroundView?.backgroundColor = .selgrosWhite
        tableStatus.backgroundColor = .selgrosWhite
        tableStatus.delegate = self
        tableStatus.dataSource = self
        
        labelTitle.generateAttributedString(fonts: ["Roboto-Bold"],
            colors: [.gray],
            sizes: [14],
            texts: ["Comanda cu id #cutare  a fost plasata"],
            alignement: .center)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
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
        
       
        return CGFloat(100)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var retCell = UITableViewCell()
        
        if (indexPath.section == 0) {
            
            let cell:ComandaStatusTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ComandaStatusTableViewCell", for: indexPath) as! ComandaStatusTableViewCell
            cell.status = (indexPath.row, OrderStatus.status0)

            retCell = cell
        }
       return retCell
    }
}
