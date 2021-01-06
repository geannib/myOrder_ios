//
//  FinalizareMetodaCell.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 12/31/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import UIKit

protocol FinalizareProtocol: NSObjectProtocol {
    
    func doMethodChanged(isCash: Bool)
    
}

class FinalizareMetodaCell: UITableViewCell {

    @IBOutlet weak var viewBakcground: UIView!
    @IBOutlet weak var imageRadioCache: UIImageView!
    @IBOutlet weak var imageRadioCard: UIImageView!
    @IBOutlet weak var labelCach: UILabel!
    @IBOutlet weak var labelCard: UILabel!
    @IBOutlet weak var imageCash: UIImageView!
    @IBOutlet weak var imageCard: UIImageView!
    
     weak var finalizareProtocol:FinalizareProtocol? = nil
    
    var isCash: Bool?  = nil{
        
        didSet {
            guard let cash = isCash else {return}
          
            if (cash == true){
                imageRadioCard.image = UIImage(named:"radio_uncheked")
                imageRadioCache.image = UIImage(named:"radio_cheked")
            }else{
                imageRadioCard.image = UIImage(named:"radio_cheked")
                imageRadioCache.image = UIImage(named:"radio_uncheked")
            }
     }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        viewBakcground.backgroundColor = .selgrosWhite
        viewBakcground.layer.cornerRadius = 10
        viewBakcground.clipsToBounds = true
        
        labelCach.generateAttributedString(fonts: ["Roboto-Regular"],
               colors: [.gray],
               sizes: [14],
               texts: ["Cash"],
               alignement: .left)
        
        labelCard.generateAttributedString(fonts: ["Roboto-Regular"],
               colors: [.black],
               sizes: [14],
               texts: ["Card de credit"],
               alignement: .left)
        
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        self.isOpaque = false
        self.contentView.backgroundColor = UIColor.clear
        self.contentView.isOpaque = false
        
        imageRadioCache.isUserInteractionEnabled = true
        let tapRadioCash = UITapGestureRecognizer(target: self, action:  #selector (self.tapCashHandler (_:)))
        tapRadioCash.numberOfTapsRequired = 1
        imageRadioCache.addGestureRecognizer(tapRadioCash)
        
        imageRadioCard.isUserInteractionEnabled = true
        let tapRadioCard = UITapGestureRecognizer(target: self, action:  #selector (self.tapCardHandler (_:)))
        tapRadioCard.numberOfTapsRequired = 1
        imageRadioCard.addGestureRecognizer(tapRadioCard)
        
        labelCach.isUserInteractionEnabled = true
        let tapLabelCach = UITapGestureRecognizer(target: self, action:  #selector (self.tapCashHandler (_:)))
        tapLabelCach.numberOfTapsRequired = 1
        labelCach.addGestureRecognizer(tapLabelCach)
        
        labelCard.isUserInteractionEnabled = true
        let tapLabelCard = UITapGestureRecognizer(target: self, action:  #selector (self.tapCardHandler (_:)))
        tapLabelCard.numberOfTapsRequired = 1
        labelCard.addGestureRecognizer(tapLabelCard)
        // Configure the view for the selected state
    }
    
    @objc func tapCashHandler(_ sender:UITapGestureRecognizer){
        
        self.finalizareProtocol?.doMethodChanged(isCash: true)
        
    }
    @objc func tapCardHandler(_ sender:UITapGestureRecognizer){
        
        self.finalizareProtocol?.doMethodChanged(isCash: false)
        
    }

}
