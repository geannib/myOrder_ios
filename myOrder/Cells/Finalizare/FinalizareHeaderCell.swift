//
//  FinalizareHeaderCell.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 12/31/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import UIKit

class FinalizareHeaderCell: UITableViewCell {

    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var labelTotalProduse: UILabel!
    @IBOutlet weak var labelTransport: UILabel!
    @IBOutlet weak var labelTOTAL: UILabel!
    @IBOutlet weak var labelTotalProduseValue: UILabel!
    @IBOutlet weak var labelTransportValue: UILabel!
    @IBOutlet weak var labelTOTALValue: UILabel!
    
    var storeId: String?  = nil{
           
           didSet {
               guard let sId = storeId else {return}
             
            let token:String = (UserDefaults.standard.value(forKey: kUDToken) ?? "") as! String
            let imgURL = API_GET_STORE_IMAGE + "?id=" + sId + "&firebase_uid=" + token;
            imageLogo.sd_setImage(with: URL(string: imgURL), placeholderImage: nil)
        }
       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewBackground.backgroundColor = .selgrosWhite
        viewBackground.layer.cornerRadius = 10
        viewBackground.clipsToBounds = true
        labelTotalProduse.generateAttributedString(fonts: ["Roboto-Bold"],
            colors: [.black],
            sizes: [15],
            texts: ["Total produse"],
            alignement: .left)
        
        labelTransport.generateAttributedString(fonts: ["Roboto-Bold"],
            colors: [.black],
            sizes: [15],
            texts: ["Transport"],
            alignement: .left)
        
        labelTOTAL.generateAttributedString(fonts: ["Roboto-Bold"],
            colors: [.black],
            sizes: [15],
            texts: ["TOTAL"],
            alignement: .left)
        
        labelTransportValue.generateAttributedString(fonts: ["Roboto-Bold"],
            colors: [.selgrosRed],
            sizes: [15],
            texts: ["20,00 RON"],
            alignement: .right)
        
        
        let products = MySession.myCart?.products
        
        var SumProducts = 0.0
        for p in  products! {
            
            SumProducts += Double(p.quantity) * p.price
        }
        
        labelTotalProduseValue.generateAttributedString(fonts: ["Roboto-Bold"],
            colors: [.selgrosRed],
            sizes: [15],
            texts: [String(SumProducts) + " RON"],
            alignement: .right)
        
        let SumTotal = 20 + SumProducts
        
        labelTOTALValue.generateAttributedString(fonts: ["Roboto-Bold"],
        colors: [.selgrosRed],
        sizes: [15],
        texts: [String(SumTotal) + " RON"],
        alignement: .right)
        
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        self.isOpaque = false
        self.contentView.backgroundColor = UIColor.clear
        self.contentView.isOpaque = false
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
