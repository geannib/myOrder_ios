//
//  ProductsViewController.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 12/8/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import UIKit

class ProductsViewController: MyBaseViewController, UICollectionViewDelegate,
UICollectionViewDataSource {

    var selCat = ""
    
    
    @IBOutlet weak var collectionProducts: UICollectionView!
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 10.0,
    left: 10.0,
    bottom: 10.0,
    right: 10.0)
    
    var products:[ProductPOJO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionProducts.dataSource = self;
        collectionProducts.delegate = self;
        collectionProducts.backgroundColor = UIColor.selgrosBackground
       // collectionProducts.shouldInvalidateLayoutForBoundsChan
        
        doAPICall()
        // Do any additional setup after loading the view.
    }
    
    func doAPICall(){
           let token:String = (UserDefaults.standard.value(forKey: kUDToken) ?? "") as! String
                  var parameters:[String: String] = ["firebase_uid": token]
           if(selCat != ""){
                      parameters = parameters + ["category_id" : selCat]
                  }
                         WebWrapper.shared.callAPI(reqType:API_GET_PRODUCTS,
                                                   parameters: parameters,
                                                   methodType: .post,
                                                   showLoader: false,
                                                   completion: { (responseType, response, error) in
                             
                        print("call done")
                        let reqResponse: ProductsResponse = ProductsResponse(JSONString: response ?? "")!
                        self.products = reqResponse.products ?? []

                        self.collectionProducts.reloadData()

                    })
       }

     func numberOfSections(in collectionView: UICollectionView) -> Int {
           // #warning Incomplete implementation, return the number of sections
           return 1
       }


        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           // #warning Incomplete implementation, return the number of items
           return products.count
           
       }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell: ProductsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCell", for: indexPath) as! ProductsCell

         
          
           let prodData = self.products[indexPath.row]
           cell.prodData = prodData
            
           return cell
       }

       // MARK: UICollectionViewDelegate

       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           
            let selProd:ProductPOJO = self.products[indexPath.row]
            let pd:MyProductDetailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyProductDetailsViewController") as! MyProductDetailsViewController
        pd.selProd = selProd
            self.navigationController?.pushViewController(pd, animated: true)
           
       }

}

// MARK: - Collection View Flow Layout Delegate
extension ProductsViewController : UICollectionViewDelegateFlowLayout {
  //1
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    //2
    let paddingSpace = (itemsPerRow + 1) * sectionInsets.left

    let availableWidth = view.frame.width - paddingSpace
       let widthPerItem = availableWidth / itemsPerRow
       
    return CGSize(width: widthPerItem, height: widthPerItem * 1.5)
   

  }
  
  //3
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
  {
      
    return sectionInsets.top - 1
  }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
  {
      
    return sectionInsets.left - 1;
  }
}
