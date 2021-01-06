//
//  CosTableViewCell.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 12/10/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import UIKit

protocol CosCellProtocol: NSObjectProtocol {
    
    func doPlus(prodId:Int, cell: CosTableViewCell) -> Bool
    func doMinus(prodId:Int, cell: CosTableViewCell) -> Bool
    func doDelete(prodId:Int, cell: CosTableViewCell) -> Bool 
    
}

class CosTableViewCell: UITableViewCell {

    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var viewLeft: UIView!
    @IBOutlet weak var viewMiddle: UIView!
    @IBOutlet weak var viewRight: UIView!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var viewCount: UIView!
    @IBOutlet weak var imgPlus: UIImageView!
    @IBOutlet weak var labelCount: UILabel!
    @IBOutlet weak var imgMinus: UIImageView!
    @IBOutlet weak var imgDelete: UIImageView!
    
     weak var cosCellProtocol:CosCellProtocol? = nil
    
    var prodBuy: MyBuyProduct?  = nil{
           
           didSet {
               guard let data = prodBuy else {return}
           
               labelTitle.text = data.description
            let pret = Double(data.price ?? 0) * Double(data.quantity ?? 0)
               labelPrice.text = String(pret) + " RON"
               labelCount.text = String (data.quantity)
               let token:String = (UserDefaults.standard.value(forKey: kUDToken) ?? "") as! String
            let imgURL = API_GET_PRODUCT_IMAGE + "?id=" + String(data.prodId) + "&firebase_uid=" + token;
               imgLogo.sd_setImage(with: URL(string: imgURL), placeholderImage: nil)
           }
       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        viewMain.backgroundColor = .red
        viewLeft.backgroundColor = .selgrosWhite
        viewRight.backgroundColor = .selgrosWhite
        viewMiddle.backgroundColor = .selgrosWhite
        imgDelete.image = UIImage(named:"trash")
        imgPlus.image = UIImage(named:"plus")
        imgMinus.image = UIImage(named:"minus")
        self.contentView.backgroundColor = UIColor.clear
        self.contentView.isOpaque = false
        self.backgroundColor = UIColor.clear
        viewCount.layer.borderColor = UIColor.selgrosGray.cgColor
        viewCount.layer.borderWidth = 1
        viewCount.clipsToBounds = true
        viewCount.layer.cornerRadius = 10
        
       let tapPlus = UITapGestureRecognizer(target: self, action:  #selector (self.plusTapped (_:)))
        tapPlus.delegate = self
        tapPlus.numberOfTapsRequired = 1
       imgPlus.isUserInteractionEnabled = true
       imgPlus.addGestureRecognizer(tapPlus)
        
        let tapMinus = UITapGestureRecognizer(target: self, action:  #selector (self.minusTapped (_:)))
        imgMinus.isUserInteractionEnabled = true
        imgMinus.addGestureRecognizer(tapMinus)
        
        let tapDel = UITapGestureRecognizer(target: self, action:  #selector (self.delTapped (_:)))
        imgDelete.isUserInteractionEnabled = true
        imgDelete.addGestureRecognizer(tapDel)
    }

    // or for Swift 4
    @objc func delTapped(_ sender:UITapGestureRecognizer){
        
        cosCellProtocol?.doDelete(prodId: prodBuy?.prodId ?? 0, cell: self)
    }
    
    // or for Swift 4
    @objc func plusTapped(_ sender:UITapGestureRecognizer){
        
        let ret = cosCellProtocol?.doPlus(prodId: prodBuy?.prodId ?? 0, cell: self)
        
    }
    
    // or for Swift 4
    @objc func minusTapped(_ sender:UITapGestureRecognizer){
         let ret = cosCellProtocol?.doMinus(prodId: prodBuy?.prodId ?? 0, cell: self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
         let ret = super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
