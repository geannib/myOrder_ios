//
//  NewAddressTableViewCell.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 1/11/21.
//  Copyright © 2021 Geanni Barbulescu. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField

class NewAddressTableViewCell: UITableViewCell {

    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var textfieldInput: JVFloatLabeledTextField!
    
    var position:Int = -1 {
        didSet{
            
            switch position {
                case 0:
                    textfieldInput.placeholder = "Strada"
                    break;
                case 1:
                   textfieldInput.placeholder = "Numar"
                   break;
                case 2:
                       textfieldInput.placeholder = "Bloc"
                       break;
                case 3:
                       textfieldInput.placeholder = "Oras"
                       break;
                case 4:
                       textfieldInput.placeholder = "Judet"
                       break;
                case 5:
                       textfieldInput.placeholder = "Tara"
                       break;
                default:
                    break;
                    
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        textfieldInput.minimumFontSize = 25
        // Configure the view for the selected state
    }

}
