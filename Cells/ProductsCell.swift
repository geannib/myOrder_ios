//
//  ProductsCell.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 12/8/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import UIKit

class ProductsCell: UICollectionViewCell {

    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imgProdus: UIImageView!
    @IBOutlet weak var viewBackground: UIView!
    
    var prodData: ProductPOJO?  = nil{
        
        didSet {
            guard let data = prodData else {return}
            
            labelTitle.text = data.name
            labelPrice.text = String(data.price ?? 0) + " lei"
            
            let token:String = (UserDefaults.standard.value(forKey: kUDToken) ?? "") as! String
            let imgURL = API_GET_PRODUCT_IMAGE + "?id=" + String(data.id!) + "&firebase_uid=" + token;
            imgProdus.sd_setImage(with: URL(string: imgURL), placeholderImage: nil)
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBackground.backgroundColor =  UIColor.selgrosWhite
        self.backgroundColor = UIColor.clear
        self.isOpaque = false
        self.contentView.backgroundColor = UIColor.clear
        self.contentView.isOpaque = false
        
        viewBackground.layer.cornerRadius = 5
        viewBackground.clipsToBounds = true
        // Initialization code
    }

   
}
