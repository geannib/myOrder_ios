//
//  FinalizareAdresaCell.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 12/31/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import UIKit

class FinalizareAdresaCell: UITableViewCell {

    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var labelAdresa: UILabel!
    @IBOutlet weak var labelTelefon: UILabel!
    @IBOutlet weak var labelAdresaValue: UILabel!
    @IBOutlet weak var labelTelefonValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        viewBackground.backgroundColor = .selgrosWhite
        viewBackground.layer.cornerRadius = 10
        viewBackground.clipsToBounds = true
        
        labelAdresa.generateAttributedString(fonts: ["Roboto-Regular"],
            colors: [.gray],
            sizes: [14],
            texts: ["Adresa: "],
            alignement: .left)
        
        labelTelefon.generateAttributedString(fonts: ["Roboto-Regular"],
            colors: [.gray],
            sizes: [14],
            texts: ["Telefon: "],
            alignement: .left)
        
        labelAdresaValue.generateAttributedString(fonts: ["Roboto-Regular"],
        colors: [.black],
        sizes: [14],
        texts: ["Bla bla bla "],
        alignement: .left)
        
        labelTelefonValue.generateAttributedString(fonts: ["Roboto-Regular"],
        colors: [.black],
        sizes: [14],
        texts: ["Bla bla bla "],
        alignement: .left)
        
        
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        self.isOpaque = false
        self.contentView.backgroundColor = UIColor.clear
        self.contentView.isOpaque = false
        // Configure the view for the selected state
    }

}
