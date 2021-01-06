//
//  CategoriesCollectionViewController.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 6/18/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import UIKit

import SDWebImage
import SideMenu
import BarcodeScanner


class CategoriesCollectionViewController: UIViewController, UICollectionViewDelegate,
    UICollectionViewDataSource{

    // MARK: - Properties
    private let itemsPerRow: CGFloat = 2
    private let reuseIdentifier = "CategoryCell"
    private let sectionInsets = UIEdgeInsets(top: 10.0,
    left: 10.0,
    bottom: 10.0,
    right: 10.0)
    
    @IBOutlet weak var collectionCategories: UICollectionView!
    var selCat:String = ""
    var selLabel:String = ""
    var storeId:String = ""
    var categories: [CategoryPOJO] = []

//    
//
    override func viewDidAppear(_ animated: Bool) {
        
    }
    override func viewWillDisappear(_ animated: Bool) {
         self.title = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = selLabel
        doAPICall()
        makeup()
        
       
       
        // Do any additional setup after loading the view.
    }
    
    func doAPICall(){
        let token:String = (UserDefaults.standard.value(forKey: kUDToken) ?? "") as! String
               var parameters:[String: String] = ["firebase_uid": token,
                                                  "store_id": storeId]
        if(selCat != ""){
                   parameters = parameters + ["parent_id" : selCat]
               }
                      WebWrapper.shared.callAPI(reqType:API_GET_STORE_CATEGORIES,
                                                parameters: parameters,
                                                methodType: .post,
                                                showLoader: false,
                                                completion: { (responseType, response, error) in
                          
                          print("call done")
                          let reqResponse: CategoriesResponse = CategoriesResponse(JSONString: response ?? "")!
                          self.categories = reqResponse.categories ?? []
                          
                                                   self.collectionCategories.reloadData()
                                  
                          })
    }
    func makeup(){
    
        if(selCat == ""){
            var imageLeft = UIImage(named: "hamburger")
            imageLeft = imageLeft?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
             self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:imageLeft , style: UIBarButtonItem.Style.plain, target: self, action: #selector(addTapped(sender:)))
        }
       
        
        var imageRightCos = UIImage(named: "cos_navigare")
        imageRightCos = imageRightCos?.withRenderingMode(UIImage.RenderingMode.automatic)
        var imageRightCod = UIImage(named: "barcode")
        imageRightCod = imageRightCod?.withRenderingMode(UIImage.RenderingMode.automatic)
        var imageRightSearch = UIImage(named: "heart_favourite")
        imageRightSearch = imageRightSearch?.withRenderingMode(UIImage.RenderingMode.automatic)
        
        let rCos = UIBarButtonItem(image: imageRightCos, style: .plain, target: self, action: #selector(basketTapped))
        let rCod = UIBarButtonItem(image: imageRightCod, style: .plain, target: self, action: #selector(basketTapped))
        let rSearch = UIBarButtonItem(image: imageRightSearch, style: .plain, target: self, action: #selector(basketTapped))
        
        // badge label
        let label = UILabel(frame: CGRect(x: 10, y: -10, width: 15, height: 15))
        label.layer.borderColor = UIColor.clear.cgColor
        label.layer.borderWidth = 2
        label.layer.cornerRadius = label.bounds.size.height / 2
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.font = UIFont(name: "SanFranciscoText-Light", size: 5)
        label.textColor = .black
        label.backgroundColor = .selgrosWhite
        label.text = "5"
        
        // cos
        let menuBtnCos = UIButton(type: .custom)
        menuBtnCos.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        menuBtnCos.setImage(UIImage(named:"cos_navigare"), for: .normal)
        menuBtnCos.addTarget(self, action: #selector(basketTapped), for: UIControl.Event.touchUpInside)
        menuBtnCos.addSubview(label)

        let menuBarItemCos = UIBarButtonItem(customView: menuBtnCos)
        let currWidth = menuBarItemCos.customView?.widthAnchor.constraint(equalToConstant: 24)
        currWidth?.isActive = true
        let currHeight = menuBarItemCos.customView?.heightAnchor.constraint(equalToConstant: 24)
        currHeight?.isActive = true
        
        //heart
        let menuBtnHeart = UIButton(type: .custom)
        menuBtnHeart.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        menuBtnHeart.setImage(UIImage(named:"heart_favourite"), for: .normal)
        menuBtnHeart.addTarget(self, action: #selector(basketTapped), for: UIControl.Event.touchUpInside)

        let menuBarItemHeart = UIBarButtonItem(customView: menuBtnHeart)
        let currWidth3 = menuBarItemHeart.customView?.widthAnchor.constraint(equalToConstant: 24)
        currWidth3?.isActive = true
        let currHeight3 = menuBarItemHeart.customView?.heightAnchor.constraint(equalToConstant: 24)
        currHeight3?.isActive = true
        
        //cod
        let menuBtnCod = UIButton(type: .custom)
        menuBtnCod.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        menuBtnCod.setImage(UIImage(named:"barcode"), for: .normal)
        menuBtnCod.addTarget(self, action: #selector(barCodTapped), for: UIControl.Event.touchUpInside)

        let menuBarItemCod = UIBarButtonItem(customView: menuBtnCod)
        let currWidth2 = menuBarItemCod.customView?.widthAnchor.constraint(equalToConstant: 24)
        currWidth2?.isActive = true
        let currHeight2 = menuBarItemCod.customView?.heightAnchor.constraint(equalToConstant: 24)
        currHeight2?.isActive = true
        
        //search
        let menuBtnSearch = UIButton(type: .custom)
        menuBtnSearch.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        menuBtnSearch.setImage(UIImage(named:"search_product"), for: .normal)
        menuBtnSearch.addTarget(self, action: #selector(basketTapped), for: UIControl.Event.touchUpInside)

        let menuBarItemSearch = UIBarButtonItem(customView: menuBtnSearch)
        let currWidth4 = menuBarItemSearch.customView?.widthAnchor.constraint(equalToConstant: 24)
        currWidth4?.isActive = true
        let currHeight4 = menuBarItemSearch.customView?.heightAnchor.constraint(equalToConstant: 24)
        currHeight4?.isActive = true
        
        self.navigationItem.rightBarButtonItems = [menuBarItemCos,
                                                   menuBarItemHeart,
                                                   menuBarItemCod,
                                                   menuBarItemSearch]
        
    }

    @objc func addTapped(sender: AnyObject) {
        let sideController:SideTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sideViewController") as! SideTableViewController
        let menu = SideMenuNavigationController(rootViewController: sideController)
        menu.leftSide = true
        // SideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration
        // of it here like setting its viewControllers. If you're using storyboards, you'll want to do something like:
        // let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
    }
    
     @objc func barCodTapped(sender: AnyObject) {
        let viewController = BarcodeScannerViewController()
        viewController.codeDelegate = self
        viewController.errorDelegate = self
        viewController.dismissalDelegate = self
        present(viewController, animated: true, completion: nil)
    }

   
    @objc func basketTapped(sender: AnyObject) {
        let cosVC:CosViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CosViewController") as! CosViewController
        self.navigationController?.pushViewController(cosVC, animated: true)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

     func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return categories.count
        
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CategoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryCollectionViewCell

      
       
        let catData = self.categories[indexPath.row]
        cell.catData = catData
        return cell
    }

    // MARK: UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let sc:CategoryPOJO = self.categories[indexPath.row]
        
        if(sc.subcategories != nil && sc.subcategories != 0){
            
            self.selCat = String(sc.id!);
            let cats:CategoriesCollectionViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CategoriesCollectionViewController") as! CategoriesCollectionViewController
            cats.selCat = String(sc.id!)
            cats.selLabel = sc.label ?? ""
            cats.storeId = self.storeId
            self.navigationController?.pushViewController(cats, animated: true)
            
        }else{
            let products:ProductsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductsViewController") as! ProductsViewController
            products.selCat = String(sc.id!)
            
            self.navigationController?.pushViewController(products, animated: true)
        }
    }

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

// MARK: - Collection View Flow Layout Delegate
extension CategoriesCollectionViewController : UICollectionViewDelegateFlowLayout {
  //1
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    //2
     let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
       let availableWidth = view.frame.width - paddingSpace
       let widthPerItem = availableWidth / itemsPerRow
       
    let hh = widthPerItem * 1.5 //- (widthPerItem * 5 / 100)
       return CGSize(width: widthPerItem, height: hh)

  }
  
  //3
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }
  
  // 4
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return sectionInsets.left
  }
}

extension CategoriesCollectionViewController:CCaroucelProtocol {
    func didSelectedItem(index: Int) {
        
        print("Item at index \(index) was selected")
        print("item \(index) was selected")
        
    }
    
    func numberOfItems() -> Int {
 
        return 0
    }
   
}

extension CategoriesCollectionViewController: BarcodeScannerCodeDelegate {
  func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
    print(code)
    controller.resetWithError(message: "Error message")
  }
}

extension CategoriesCollectionViewController: BarcodeScannerErrorDelegate {
  func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
    print(error)
  }
}

extension CategoriesCollectionViewController: BarcodeScannerDismissalDelegate {
  func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
    controller.dismiss(animated: true, completion: nil)
  }
}
