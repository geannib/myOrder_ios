//
//  FinalizareViewController.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 12/31/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import UIKit

class FinalizareViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FinalizareProtocol{
    @IBOutlet weak var labelNext: UILabel!
    @IBOutlet weak var tableFinalizare: UITableView!
    
    @IBOutlet weak var viewNext: UIView!
    
    var storeId:String = ""
    var isMethodCash = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        makeup()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Plaseaza comanda"
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    
    func makeup(){
        tableFinalizare.dataSource = self;
        tableFinalizare.delegate = self;
        tableFinalizare.separatorStyle = .none
        tableFinalizare.backgroundView?.backgroundColor = .selgrosGray
        tableFinalizare.backgroundColor = .selgrosGray
        
        viewNext.backgroundColor = .selgrosGray
        
        labelNext.generateNext(title:"FINALIZARE COMANDA", isEnabled: true)
        labelNext.isUserInteractionEnabled = true
         let tapNext = UITapGestureRecognizer(target: self, action:  #selector (self.nextTapped (_:)))
        tapNext.numberOfTapsRequired = 1
        labelNext.addGestureRecognizer(tapNext)
    }

    @objc func nextTapped(_ sender:UITapGestureRecognizer){
           let orderStatus:OrderStatusViewController =
               UIStoryboard(name: "Finalizare", bundle: nil).instantiateViewController(withIdentifier: "OrderStatusViewController") as! OrderStatusViewController
           self.navigationController?.pushViewController(orderStatus, animated: true)
//        
//        let fModal:FinalizareDialogViewController =
//                        UIStoryboard(name: "Finalizare", bundle: nil).instantiateViewController(withIdentifier: "FinalizareDialogViewController") as! FinalizareDialogViewController
//        fModal.modalPresentationStyle = .overCurrentContext
//                self.present(fModal, animated: false, completion: nil)
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 4
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return CGFloat.leastNormalMagnitude
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if (section == 0){
            return CGFloat.leastNormalMagnitude
        }
        return 50
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var retVal = 0
        switch indexPath.section {
        case 0:
            retVal = 150
            break;
        case 1:
            retVal = 75
            break
        case 2:
            retVal = 100
            break;
        case 3:
            retVal = 100
            break;
        default:
            retVal = 0
        }
        return CGFloat(retVal)
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if( section == 1){
            return "Adresa de livreare"
        }
        
        if (section == 2){
            return "Metoda de plata"
        }
        
        if (section == 3){
            return "Mentiuni"
        }
        
        return ""
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var retCell = UITableViewCell()
        
        if (indexPath.section == 0) {
            
            let hCell:FinalizareHeaderCell = tableView.dequeueReusableCell(withIdentifier: "FinalizareHeaderCell", for: indexPath) as! FinalizareHeaderCell

            hCell.storeId = MySession.selStoreId
            retCell = hCell
        }
        
        if (indexPath.section == 1) {
            
            let addresseCell:FinalizareAdresaCell = tableView.dequeueReusableCell(withIdentifier: "FinalizareAdresaCell", for: indexPath) as! FinalizareAdresaCell

            retCell = addresseCell
        }
        
        if (indexPath.section == 2) {
            
            let metodaCell:FinalizareMetodaCell = tableView.dequeueReusableCell(withIdentifier: "FinalizareMetodaCell", for: indexPath) as! FinalizareMetodaCell

            metodaCell.finalizareProtocol = self;
            metodaCell.isCash = self.isMethodCash
            retCell = metodaCell
        }
        
        if (indexPath.section == 3) {
            
            let mentiuniCell:FinalizareMentiuniCell = tableView.dequeueReusableCell(withIdentifier: "FinalizareMentiuniCell", for: indexPath) as! FinalizareMentiuniCell

            retCell = mentiuniCell
        }
       
        return retCell
    }
    
    func doMethodChanged(isCash: Bool){
        
        self.isMethodCash = isCash
       let indexPosition = IndexPath(row: 0, section: 2)
        tableFinalizare.reloadRows(at: [indexPosition], with: .none)
    }

}
