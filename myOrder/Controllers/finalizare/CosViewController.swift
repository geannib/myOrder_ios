//
//  CosViewController.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 6/24/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import UIKit
import SideMenu

class CosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let cosProducts = MySession.myCart?.getProducts()
        return cosProducts?.count ?? 0
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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let prodCell:CosTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CosTableViewCell", for: indexPath) as! CosTableViewCell

        // Configure the cell...
        let prod = MySession.myCart?.products[indexPath.row]
        prodCell.prodBuy = prod
        prodCell.cosCellProtocol = self
        return prodCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 5
    }
    

    @IBOutlet weak var tableCos: UITableView!
    
    @IBOutlet weak var viewComanda: UIView!
    @IBOutlet weak var viewDetalii: UIView!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var labelTotalProduse: UILabel!
    @IBOutlet weak var labelTransport: UILabel!
    @IBOutlet weak var labelTotalPlata: UILabel!
    @IBOutlet weak var labelTotalProduseValue: UILabel!
    @IBOutlet weak var labelTotalPlataValue: UILabel!
    @IBOutlet weak var labelTransportValue: UILabel!
    @IBOutlet weak var labelComanda: UILabel!
    @IBOutlet weak var labelError: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
         self.title = "Cosul de cumparaturi"
     }
   
    override func viewWillDisappear(_ animated: Bool) {
         self.title = ""
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()

        makeup()
        setHandlers()
        // Do any additional setup after loading the view.
    }
    
    func setHandlers(){
        
        labelComanda.isUserInteractionEnabled = true
        let tapNext = UITapGestureRecognizer(target: self, action:  #selector (self.nextTapped (_:)))
       tapNext.numberOfTapsRequired = 1
       labelComanda.addGestureRecognizer(tapNext)
    }
    @objc func nextTapped(_ sender:UITapGestureRecognizer){
        

        let finalizare:FinalizareViewController =
            UIStoryboard(name: "Finalizare", bundle: nil).instantiateViewController(withIdentifier: "FinalizareViewController") as! FinalizareViewController
        self.navigationController?.pushViewController(finalizare, animated: true)
    }
    func makeup(){
        
        viewMain.backgroundColor = .selgrosWhite
        viewComanda.backgroundColor = .selgrosRed
//        viewComanda.layer.cornerRadius = 10
//        viewComanda.layer.borderColor = UIColor.selgrosGray.cgColor
//        viewComanda.layer.borderWidth = 1
//        viewComanda.clipsToBounds = true
        viewDetalii.backgroundColor = .selgrosWhite
        
        labelTotalProduse.text = "Total Produse"
        labelTotalProduse.textAlignment = .left
        labelTransport.text = "Transport:"
        labelTransport.textAlignment = .left
        labelTotalPlata.text = "Total plata"
        labelTotalPlata.textAlignment = .left
        //labelTotalProduseValue.text = "30 RON"
        labelTotalProduseValue.textAlignment = .right
        labelTransportValue.text = "20 RON"
        labelTransportValue.textAlignment = .right
       // labelTotalPlataValue.text = "50 RON"
        labelTotalPlataValue.textAlignment = .right
        
//        labelComanda.text = "TRIMITE COMANDA"
//        labelComanda.textAlignment = .center
//        labelComanda.backgroundColor = .clear
//        labelComanda.textColor = .selgrosWhite
        labelComanda.generateNext(title: "TRIMITE COMANDA", isEnabled: true)
        
        tableCos.dataSource = self
        tableCos.delegate = self
        tableCos.separatorStyle = .none
        tableCos.backgroundColor = UIColor.selgrosBackground
        
        let products = MySession.myCart?.products ?? []
        var sum = 0.0
        for p in products {
            sum += Double(p.price) * Double(p.quantity)
        }
        labelTotalProduseValue.text = String(sum) + " RON"
        labelTotalPlataValue.text = String(sum + 20) + " RON"
        
        if (products.count == 0){
            
            tableCos.isHidden == true
            labelError.text = "Nu avem produse in cos"
            labelError.isHidden = false
        }else{
            tableCos.isHidden = false
            labelError.isHidden = true
        }
        var imageLeft = UIImage(named: "hamburger")
        imageLeft = imageLeft?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        // self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:imageLeft , style: UIBarButtonItem.Style.plain, target: self, action: #selector(showBurger(sender:)))
    }

    @objc func showBurger(sender: AnyObject) {
        let sideController:SideTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sideViewController") as! SideTableViewController
        let menu = SideMenuNavigationController(rootViewController: sideController)
        menu.leftSide = true
        // SideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration
        // of it here like setting its viewControllers. If you're using storyboards, you'll want to do something like:
        // let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
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

extension CosViewController: CosCellProtocol {
    func doPlus(prodId:Int, cell: CosTableViewCell) -> Bool {
        print("doPlus")
        let products = MySession.myCart?.products
        var fProd = MyBuyProduct()
        for p in  products! {
            
            if (p.prodId == prodId){
                p.quantity += 1
                MySession.myCart?.addProduct(prod: p)
                fProd = p
            }
        }
        MySession.saveCart()
        cell.prodBuy = fProd
        return true
    }
    
    func doMinus(prodId:Int, cell: CosTableViewCell)-> Bool  {
        print("doMinus")
        var fProd = MyBuyProduct()
        let products = MySession.myCart?.products
               for p in  products! {
                   
                   if (p.prodId == prodId){
                       p.quantity -= 1
                       MySession.myCart?.addProduct(prod: p)
                       fProd = p
                   }
               }
               MySession.saveCart()
        cell.prodBuy = fProd
        return true
    }
    
    func doDelete(prodId:Int, cell: CosTableViewCell) -> Bool {
        
        print("doDelete")
        MySession.myCart?.removeProduct(prodId: prodId)

        MySession.saveCart()
        self.tableCos.reloadData()
        return true
    }
    
    
}
