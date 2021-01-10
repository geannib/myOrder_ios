//
//  AddressTableViewCell.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 1/10/21.
//  Copyright © 2021 Geanni Barbulescu. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {

    @IBOutlet weak var labelRegion: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imgLocation: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
