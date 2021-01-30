//
//  MyOrderDetailsViewController.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 12/10/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import UIKit

class MyProductDetailsViewController: MyBaseViewController {

    var selProd:ProductPOJO? = nil
    var buyProd:MyBuyProduct? = nil
    
    @IBOutlet weak var viewMain: UIView!
    
    @IBOutlet weak var viewBottomCount: UIView!
    @IBOutlet weak var viewBottomComanda: UIView!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var labelBottomComanda: UILabel!
    
    @IBOutlet weak var viewMiddle: UIView!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var labelBottomCount: UILabel!
    @IBOutlet weak var imgBottomPlus: UIImageView!
    @IBOutlet weak var imgBottomMinus: UIImageView!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var viewTopDetails: UIView!
    @IBOutlet weak var labelDetails: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelInstructionsTitle: UILabel!
    @IBOutlet weak var txtviewInstructions: UITextView!
    @IBOutlet weak var viewHeart: UIView!
    @IBOutlet weak var imageHeart: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        makeup()
        // Do any additional setup after loading the view.
    }
    
    func makeup(){
        viewMain.backgroundColor = UIColor.selgrosBackground
        viewTop.backgroundColor = .selgrosBackground
        viewBottom.backgroundColor = .selgrosBackground
        viewBottomComanda.backgroundColor = .selgrosRed
        viewBottomCount.backgroundColor = .selgrosBackground
        viewTopDetails.backgroundColor = .clear
        labelBottomComanda.text = "ADAUGA IN COS"
        labelBottomComanda.backgroundColor = .clear
        labelBottomComanda.textColor = .selgrosWhite
        labelBottomComanda.textAlignment = .center
        viewBottomComanda.layer.borderColor = UIColor.selgrosGray.cgColor
        viewBottomComanda.clipsToBounds = true
        viewBottomComanda.layer.cornerRadius = 10
        
        viewBottomCount.layer.borderColor = UIColor.selgrosGray.cgColor
        viewBottomCount.layer.borderWidth = 1
        viewBottomCount.clipsToBounds = true
        viewBottomCount.layer.cornerRadius = 10
        labelBottomCount.textAlignment = .center
       
        
        imgBottomPlus.image = UIImage(named: "plus")
        imgBottomMinus.image = UIImage(named: "minus")
        
        viewMiddle.backgroundColor = .selgrosBackground
        
        labelInstructionsTitle.generateAttributedString(
            fonts: ["Roboto-Regular"],
            colors: [.selgrosTitle],
            sizes: [13],
            texts: ["Instructiuni pentru alegerea produsului: "],
            alignement: .left)
        txtviewInstructions.layer.borderColor = UIColor.selgrosGray.cgColor
        txtviewInstructions.clipsToBounds = true
        txtviewInstructions.layer.cornerRadius = 10
        txtviewInstructions.layer.borderColor = UIColor.selgrosGray.cgColor
        txtviewInstructions.layer.borderWidth = 1
        
        labelDetails.numberOfLines = 2
       
        
        let token:String = (UserDefaults.standard.value(forKey: kUDToken) ?? "") as! String
        
         self.txtviewInstructions.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        
        guard let data = selProd else {return}

        labelDetails.generateAttributedString(
            fonts: ["Roboto-Bold"],
            colors: [.black],
            sizes: [17],
            texts: [data.name ?? ""],
            alignement: .left)

        var fullPrice = data.price ?? "-"
        let slices:[String] = fullPrice.components(separatedBy: ".")
        fullPrice += " RON"
        if(slices.count == 2) {
            let font:UIFont? = UIFont(name: "Roboto-Bold", size:20)
            let fontSuper:UIFont? = UIFont(name: "Roboto-Bold", size:10)
            let attString:NSMutableAttributedString = NSMutableAttributedString(string: fullPrice, attributes: [.font:font!])
            attString.setAttributes([.font:fontSuper!,.baselineOffset:10],
                                    range: NSRange(location:slices[0].count + 1, length:slices[1].count))
            attString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location: 0, length: fullPrice.count))
            
            labelPrice.attributedText = attString
        }
        else{
            labelPrice.generateAttributedString(
                fonts: ["Roboto-Bold"],
                colors: [.selgrosRed],
                sizes: [17],
                texts: [fullPrice],
                alignement: .left)
        }
        
        viewHeart.backgroundColor = .white
        viewHeart.layer.borderColor = UIColor.selgrosGray.cgColor
        viewHeart.clipsToBounds = true
        viewHeart.layer.cornerRadius = 5
        viewHeart.layer.borderColor = UIColor.selgrosGray.cgColor
        viewHeart.layer.borderWidth = 1
        
        let products = MySession.myCart?.products ?? []
        for p in products {
           if (p.prodId == selProd?.id){
               buyProd = p
               break;
           }
        }
        
        let imgURL = API_GET_PRODUCT_IMAGE + "?id=" + String(data.id!) + "&firebase_uid=" + token;
        imgLogo.sd_setImage(with: URL(string: imgURL), placeholderImage: nil)
        
        let tapHeart = UITapGestureRecognizer(target: self, action:  #selector (self.heartTapped (_:)))
        viewHeart.isUserInteractionEnabled = true
        viewHeart.addGestureRecognizer(tapHeart)
        
        let tapBuy = UITapGestureRecognizer(target: self, action:  #selector (self.buyTapped (_:)))
        labelBottomComanda.isUserInteractionEnabled = true
        labelBottomComanda.addGestureRecognizer(tapBuy)
        
        let tapPlus = UITapGestureRecognizer(target: self, action:  #selector (self.plusTapped (_:)))
        imgBottomPlus.isUserInteractionEnabled = true
        imgBottomPlus.addGestureRecognizer(tapPlus)

        let tapMinus = UITapGestureRecognizer(target: self, action:  #selector (self.minusTapped (_:)))
        imgBottomMinus.isUserInteractionEnabled = true
        imgBottomMinus.addGestureRecognizer(tapMinus)
        
        buyProd = MyBuyProduct()
        setFavImage()
    
        let adjustQ = buyProd?.quantity ?? 0
        
        labelBottomCount.generateAttributedString(
               fonts: ["Roboto-Bold"],
               colors: [.selgrosSubtitle],
               sizes: [25],
               texts: [String((adjustQ == 0) ? 1 : adjustQ)],
               alignement: .center)

    }
       
        @objc func tapDone(sender: Any) {
            self.txtviewInstructions.endEditing(true)
        }
    
       // or for Swift 4
       @objc func plusTapped(_ sender:UITapGestureRecognizer){
        
        var maxQ = selProd?.MaxSellingQuantity ?? 0
        maxQ = (maxQ == 0) ? 10 : 0
        if ( Double(buyProd?.quantity ?? 0) < maxQ){
            
            buyProd?.quantity += 1
            MySession.myCart?.addProduct(prod: buyProd!)
            labelBottomCount.generateAttributedString(
            fonts: ["Roboto-Bold"],
            colors: [.selgrosSubtitle],
            sizes: [25],
            texts: [String(buyProd?.quantity ?? 0)],
            alignement: .center)
        }
       }
       
    
    // or for Swift 4
    @objc func heartTapped(_ sender:UITapGestureRecognizer){
        print("Favourite tapped")
        let token:String = (UserDefaults.standard.value(forKey: kUDToken) ?? "") as! String
        let parameters:[String: String] = ["firebase_uid": token,
                                           "product_id" : String(selProd?.id ?? 0),
                                           "store_id": MySession.selStoreId ?? "",
                                           "quantity" : String(buyProd?.quantity ?? 0)]
        
        var found = false
        for p in MySession.prodFavs {
            if (p.idProd == selProd?.id){
                found = true
                break
            }
        }
        
        var apiCall = API_SAVE_FAVORITE_PRODUCT
        if(found == true){
            apiCall = API_REMOVE_FAVORITE_PRODUCT
        }
        
        WebWrapper.shared.callAPI(reqType:apiCall,
                                  parameters: parameters,
                                  methodType: .post,
                                  showLoader: false,
                                  completion: { (responseType, response, error) in
            
                    print("call done")
                    let reqResponse: SaveFavProdResponse = SaveFavProdResponse(JSONString: response ?? "")!
                    if(reqResponse.data == true){
                        print(" fav product on \(apiCall) is true")
                        self.refreshFavList()
                    }
                                    
        })
    }
    
    func setFavImage(){

        imageHeart.image = UIImage(named: "heart_empty")
        for p in MySession.prodFavs {
            if (p.idProd == selProd?.id){
                imageHeart.image = UIImage(named: "heart_red")
            }
        }
    }
    func refreshFavList(){
        let token:String = (UserDefaults.standard.value(forKey: kUDToken) ?? "") as! String
        let parameters:[String: String] = ["firebase_uid": token,
                                           "store_id": String(MySession.selStoreId ?? "")]
        
        WebWrapper.shared.callAPI(reqType:API_GET_ALL_FAVORITE_PRODUCT,
                                  parameters: parameters,
                                  methodType: .post,
                                  showLoader: false,
                                  completion: { (responseType, response, error) in
            
            print("call done")
            guard let _ = error else{
                print("error  occured on calling \(API_GET_ALL_FAVORITE_PRODUCT): \(error.debugDescription)")
                return;
            }
                                    
            let reqResponse: MyFavProductResponse = MyFavProductResponse(JSONString: response ?? "")!
            MySession.prodFavs = reqResponse.prodFavs ?? []
                                    self.setFavImage()
                                    
        })
    }
    
       // or for Swift 4
       @objc func minusTapped(_ sender:UITapGestureRecognizer){
           if ( Double(buyProd?.quantity ?? 0) > 0){
               
               buyProd?.quantity -= 1
               MySession.myCart?.addProduct(prod: buyProd!)
               labelBottomCount.text = String(buyProd?.quantity ?? 0)
           }
       }
    // or for Swift 4
    @objc func buyTapped(_ sender:UITapGestureRecognizer){
        
//        buyProd.prodId = selProd?.id as! Int
//        buyProd.quantity = Int(labelBottomCount.text ?? "0")!
//        buyProd.description = selProd?.name! as! String
//        buyProd.price = Double(selProd?.price ?? "0.0") ?? 0.0
        
        MySession.myCart?.addProduct(prod: buyProd!)
        MySession.saveCart()
        
        //Update cart badge TODO
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
