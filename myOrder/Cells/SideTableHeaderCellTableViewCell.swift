//
//  SideTableHeaderCellTableViewCell.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 12/30/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import UIKit

class SideTableHeaderCellTableViewCell: UITableViewCell {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var viewBackground: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        viewBackground.backgroundColor = .selgrosGray
        
        
        // Configure the view for the selected state
    }

}
