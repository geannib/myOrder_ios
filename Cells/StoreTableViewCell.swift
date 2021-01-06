//
//  StoreTableViewCell.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 11/16/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import UIKit

class StoreTableViewCell: UITableViewCell {

    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var imgClock: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var viewTaxa: UIView!
    @IBOutlet weak var viewValoare: UIView!
    @IBOutlet weak var viewSeparator: UIView!
    @IBOutlet weak var viewTimp: UIView!
    @IBOutlet weak var labelOpen: UILabel!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var labelOrar: UILabel!
    @IBOutlet weak var labelTaxaTitle: UILabel!
    @IBOutlet weak var labelTaxaValue: UILabel!
    @IBOutlet weak var labelValoareTitle: UILabel!
    @IBOutlet weak var labelValoareValue: UILabel!
    @IBOutlet weak var labelTimpTitle: UILabel!
    @IBOutlet weak var labelTimpValue: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewMain.backgroundColor = UIColor.selgrosWhite
        viewTop.backgroundColor = UIColor.selgrosWhite
        viewBottom.backgroundColor = UIColor.red
        viewTaxa.backgroundColor = UIColor.selgrosWhite
        viewValoare.backgroundColor = UIColor.selgrosWhite
        viewTimp.backgroundColor = UIColor.selgrosWhite
        viewSeparator.backgroundColor = UIColor.selgrosGray
        labelTimpValue.numberOfLines = 1
        labelTimpTitle.numberOfLines = 2
        labelTaxaValue.numberOfLines = 2
        labelTaxaTitle.numberOfLines = 2
        labelValoareValue.numberOfLines = 1
        labelValoareTitle.numberOfLines = 2
        labelTimpTitle.textAlignment = .center
        labelTimpValue.textAlignment = .center
        labelValoareValue.textAlignment = .center
        labelValoareTitle.textAlignment = .center
        labelTaxaValue.textAlignment = .center
        labelTaxaTitle.textAlignment = .center
        self.backgroundColor = UIColor.clear
        self.isOpaque = false
        self.contentView.backgroundColor = UIColor.clear
        self.contentView.isOpaque = false
        
        viewMain.layer.cornerRadius = 15
        viewMain.clipsToBounds = true
        // Initialization code
        
        imgClock.image = UIImage(named: "clock")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
