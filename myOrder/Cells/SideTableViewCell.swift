//
//  SideTableViewCell.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 6/19/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import UIKit

class SideTableViewCell: UITableViewCell {

    @IBOutlet weak var imageLeft: UIImageView!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        viewBackground.backgroundColor = .selgrosWhite
        // Configure the view for the selected state
    }

}
