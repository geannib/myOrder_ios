//
//  FinalizareMentiuniCell.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 12/31/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import UIKit

class FinalizareMentiuniCell: UITableViewCell {

    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var textFieldMentiuni: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        self.isOpaque = false
        self.contentView.backgroundColor = UIColor.clear
        self.contentView.isOpaque = false
        
        viewBackground.backgroundColor = .selgrosWhite
        viewBackground.layer.cornerRadius = 10
        viewBackground.clipsToBounds = true
        
        textFieldMentiuni.text = "Mentiuni"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        viewBackground.backgroundColor = .selgrosWhite
        // Configure the view for the selected state
    }

}
