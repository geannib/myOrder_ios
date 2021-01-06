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
    
    var storePOJO: StorePOJO?  = nil{
        
        didSet {
            guard let data = storePOJO else {return}
        
            let token:String = (UserDefaults.standard.value(forKey: kUDToken) ?? "") as! String
            let imgURL = API_GET_STORE_IMAGE + "?id=" + String(data.id!) + "&firebase_uid=" + token;

            labelName.generateAttributedString(
                fonts: ["Roboto-Bold"],
                colors: [.selgrosTitle],
                sizes: [25],
                texts: [data.name ?? ""],
                alignement: .left)
            labelOrar.text = data.openHour! + "-" + data.closeHour!
            labelType.generateAttributedString(
                fonts: ["Roboto-Regular"],
                colors: [.selgrosTitle],
                sizes: [15],
                texts: [data.label ?? ""],
                alignement: .left)
            let ch = data.closeHour ?? ""
            let oh = data.openHour ?? ""
            
        
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "HH:mm"
            let dateClose = dateFormatter.date(from:ch)!
            let dateOpen = dateFormatter.date(from:oh)!
            let now = Date()
            
            let isOpen = now > dateOpen && now < dateClose
            let openStr = (isOpen) ? "open" : "close"
            
            labelOpen.generateAttributedString(
                fonts: [(isOpen) ? "Roboto-Regular" : "Roboto-Bold"],
                colors: [(isOpen) ? .selgrosTitle : .selgrosSubtitle],
                sizes: [15],
                texts: [openStr],
                alignement: .left)
            
            labelTaxaTitle.generateAttributedString(
                fonts: ["Roboto-Regular"],
                colors: [.selgrosSubtitle],
                sizes: [15],
                texts: ["Colectare livrare:"],
                alignement: .center)
            labelTaxaValue.generateAttributedString(
                fonts: ["Roboto-Bold"],
                colors: [.selgrosTitle],
                sizes: [15],
                texts: [(data.orderFee ?? "") + " RON"],
                alignement: .center)
            labelValoareTitle.generateAttributedString(
                fonts: ["Roboto-Regular"],
                colors: [.selgrosSubtitle],
                sizes: [15],
                texts: ["Comanda minima:"],
                alignement: .center)
            labelValoareValue.generateAttributedString(
                fonts: ["Roboto-Bold"],
                colors: [.selgrosTitle],
                sizes: [15],
                texts: [(data.minimumOrder ?? "") + " RON"],
                alignement: .center)
            labelTimpTitle.generateAttributedString(
                fonts: ["Roboto-Regular"],
                colors: [.selgrosSubtitle],
                sizes: [15],
                texts: ["Timp livrare:"],
                alignement: .center)
            let deliveryTxt = "~" + String(data.deliveryTime ?? 0) + " min"
            labelTimpValue.generateAttributedString(
                fonts: ["Roboto-Bold"],
                colors: [.selgrosRed],
                sizes: [15],
                texts: [deliveryTxt],
                alignement: .center)
            imgLogo.sd_setImage(with: URL(string: imgURL), placeholderImage: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewMain.backgroundColor = UIColor.selgrosWhite
        viewTop.backgroundColor = UIColor.selgrosWhite
        viewBottom.backgroundColor = UIColor.selgrosWhite
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
