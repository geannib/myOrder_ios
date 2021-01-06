//
//  CategoryCollectionViewCell.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 6/18/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var imgCategory: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    

    var catData: CategoryPOJO?  = nil{
        
        didSet {
            guard let data = catData else {return}
            
            labelTitle.text = data.label
            let token:String = (UserDefaults.standard.value(forKey: kUDToken) ?? "") as! String
            let imgURL = API_GET_CATEGORY_IMAGE + "?id=" + String(data.id!) + "&firebase_uid=" + token;
            imgCategory.sd_setImage(with: URL(string: imgURL), placeholderImage: nil)
        }
    }

    //creation from nib requires this method to be overridden
    override func awakeFromNib() {
        super.awakeFromNib()
        
        labelTitle.textAlignment = .center
        labelTitle.backgroundColor  = .white
        viewBackground.backgroundColor = .white
        // corner radius
        viewBackground.layer.cornerRadius = 10

        // border
        viewBackground.layer.borderWidth = 1.0
        viewBackground.layer.borderColor = UIColor.black.cgColor

        // shadow
        viewBackground.layer.shadowColor = UIColor.black.cgColor
        viewBackground.layer.shadowOffset = CGSize(width: 3, height: 3)
        viewBackground.layer.shadowOpacity = 0.7
        viewBackground.layer.shadowRadius = 4.0
        // Initialization code
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
      
    }
    
}
