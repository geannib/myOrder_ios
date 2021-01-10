//
//  ComandaStatusTableViewCell.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 12/31/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import UIKit

enum OrderStatus {
    case status0
    case status1
    case status2
    case status3
}

class ComandaStatusTableViewCell: UITableViewCell {

    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var viewTrack2: UIView!
    @IBOutlet weak var viewTrack1: UIView!
    @IBOutlet weak var imageState: UIImageView!
    @IBOutlet weak var labelState: UILabel!
    
    var status: (Int, OrderStatus?) = (0, nil) {
          
          didSet {
            guard let v = status.1 else {return}
            let cellIdx = status.0
            
            var imgName = ""
            var labelStr = ""
            var upperHidden = (cellIdx == 0) ? true : false
            var lowerHidden = (cellIdx == 3) ? true : false
            
            switch cellIdx {
                case 0:
                    imgName = ( v == OrderStatus.status0) ? "shop_activ" : "shop_inactiv"
                    labelStr = ( v == OrderStatus.status0) ? "Se cumpara" : ""
                    break;
                    
                case 1:
                    imgName = ( v == OrderStatus.status1) ? "shop_activ" : "shop_inactiv"
                    labelStr = ( v == OrderStatus.status1) ? "Se ceva" : ""
                   break;
                    
                case 2:
                    imgName = (v == OrderStatus.status2) ? "delivery_activ" : "delivery_inactiv"
                    labelStr = ( v == OrderStatus.status2) ? "Se livreaza" : ""
                    break;
                    
                case 3:
                   imgName = ( v == OrderStatus.status3) ? "delivered_activ" : "delivered_inactiv"
                   labelStr = ( v == OrderStatus.status3) ? "S-a livrat" : ""
                   break;
                
            default:
                break;
           
            }
            
        makeup(imgName: imgName, labelStr: labelStr, upperHidden: upperHidden, lowerHidden: lowerHidden)
      }
    }
    
    func makeup(imgName:String, labelStr:String, upperHidden:Bool, lowerHidden:Bool){
        
        labelState.generateAttributedString(fonts: ["Roboto-Regular"],
        colors: [.gray], 
        sizes: [20],
        texts: [labelStr],
        alignement: .left)
        
        imageState.image = UIImage(named:imgName)
        
        viewBackground.backgroundColor = .clear
        viewTrack1.isHidden = upperHidden
        viewTrack2.isHidden = lowerHidden
        
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clear
        self.isOpaque = false
        self.contentView.backgroundColor = UIColor.clear
        self.contentView.isOpaque = false
        self.selectionStyle = .none
        
        // Initialization code
        
        viewTrack2.backgroundColor = .black
        viewTrack1.backgroundColor = .black
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
