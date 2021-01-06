//
//  ProductTableViewCell.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 6/19/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var viewRibbon: UIView!
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        viewBackground.backgroundColor = .black
        viewRibbon.backgroundColor = .black
        viewRibbon.alpha = 1
        labelTitle.textColor = .white
        labelDescription.textColor = .white
        labelPrice.textColor = .white
        
        labelPrice.isOpaque = true
        labelTitle.isOpaque = true
        labelDescription.isOpaque = true
        
        // Configure the view for the selected state
    }

}
