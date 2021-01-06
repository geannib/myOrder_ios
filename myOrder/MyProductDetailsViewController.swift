//
//  MyOrderDetailsViewController.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 12/10/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import UIKit

class MyProductDetailsViewController: MyBaseViewController {

    var selProd:ProductPOJO? = nil
    var buyProd:MyBuyProduct? = nil
    
    @IBOutlet weak var viewMain: UIView!
    
    @IBOutlet weak var viewBottomCount: UIView!
    @IBOutlet weak var viewBottomComanda: UIView!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var labelBottomComanda: UILabel!
    
    @IBOutlet weak var viewMiddle: UIView!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var labelBottomCount: UILabel!
    @IBOutlet weak var imgBottomPlus: UIImageView!
    @IBOutlet weak var imgBottomMinus: UIImageView!
    @IBOutlet weak var imgLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        makeup()
        // Do any additional setup after loading the view.
    }
    
    func makeup(){
        viewMain.backgroundColor = UIColor.selgrosBackground
        viewTop.backgroundColor = .selgrosBackground
        viewBottom.backgroundColor = .selgrosBackground
        viewBottomComanda.backgroundColor = .selgrosRed
        viewBottomCount.backgroundColor = .selgrosBackground
        labelBottomComanda.text = "COMANDA"
        labelBottomComanda.backgroundColor = .clear
        labelBottomComanda.textColor = .selgrosWhite
        labelBottomComanda.textAlignment = .center
        viewBottomComanda.layer.borderColor = UIColor.selgrosGray.cgColor
        viewBottomComanda.clipsToBounds = true
        viewBottomComanda.layer.cornerRadius = 10
        
        viewBottomCount.layer.borderColor = UIColor.selgrosGray.cgColor
        viewBottomCount.layer.borderWidth = 1
        viewBottomCount.clipsToBounds = true
        viewBottomCount.layer.cornerRadius = 10
        labelBottomCount.textAlignment = .center
       
        
        imgBottomPlus.image = UIImage(named: "plus")
        imgBottomMinus.image = UIImage(named: "minus")
        
        let token:String = (UserDefaults.standard.value(forKey: kUDToken) ?? "") as! String
        
        guard let data = selProd else {return}
        let imgURL = API_GET_PRODUCT_IMAGE + "?id=" + String(data.id!) + "&firebase_uid=" + token;
        imgLogo.sd_setImage(with: URL(string: imgURL), placeholderImage: nil)
        
        let tapBuy = UITapGestureRecognizer(target: self, action:  #selector (self.buyTapped (_:)))
        labelBottomComanda.isUserInteractionEnabled = true
        labelBottomComanda.addGestureRecognizer(tapBuy)
        
        let tapPlus = UITapGestureRecognizer(target: self, action:  #selector (self.plusTapped (_:)))
        imgBottomPlus.isUserInteractionEnabled = true
        imgBottomPlus.addGestureRecognizer(tapPlus)

        let tapMinus = UITapGestureRecognizer(target: self, action:  #selector (self.minusTapped (_:)))
        imgBottomMinus.isUserInteractionEnabled = true
        imgBottomMinus.addGestureRecognizer(tapMinus)
        
        buyProd = MyBuyProduct()
        let products = MySession.myCart?.products ?? []
        for p in products {
            if (p.prodId == selProd?.id){
                buyProd = p
                break;
            }
        }
    
        let adjustQ = buyProd?.quantity ?? 0
        
        labelBottomCount.generateAttributedString(
               fonts: ["Roboto-Bold"],
               colors: [.selgrosSubtitle],
               sizes: [25],
               texts: [String((adjustQ == 0) ? 1 : adjustQ)],
               alignement: .center)

    }
       
       // or for Swift 4
       @objc func plusTapped(_ sender:UITapGestureRecognizer){
        
        var maxQ = selProd?.MaxSellingQuantity ?? 0
        maxQ = (maxQ == 0) ? 10 : 0
        if ( Double(buyProd?.quantity ?? 0) < maxQ){
            
            buyProd?.quantity += 1
            MySession.myCart?.addProduct(prod: buyProd!)
            labelBottomCount.generateAttributedString(
            fonts: ["Roboto-Bold"],
            colors: [.selgrosSubtitle],
            sizes: [25],
            texts: [String(buyProd?.quantity ?? 0)],
            alignement: .center)
        }
       }
       
       // or for Swift 4
       @objc func minusTapped(_ sender:UITapGestureRecognizer){
           if ( Double(buyProd?.quantity ?? 0) > 0){
               
               buyProd?.quantity -= 1
               MySession.myCart?.addProduct(prod: buyProd!)
               labelBottomCount.text = String(buyProd?.quantity ?? 0)
           }
       }
    // or for Swift 4
    @objc func buyTapped(_ sender:UITapGestureRecognizer){
        
        let buyProd = MyBuyProduct()
        buyProd.prodId = selProd?.id as! Int
        buyProd.quantity = Int(labelBottomCount.text ?? "0")!
        buyProd.description = selProd?.name! as! String
        buyProd.price = Double(selProd?.price ?? "0.0") ?? 0.0
        
        MySession.myCart?.addProduct(prod: buyProd)
        MySession.saveCart()
        
        //Update cart badge TODO
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
