//
//  StoresViewControllerTableViewController.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 11/16/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import UIKit
import FirebaseAuth
import SideMenu


class StoresViewController: UIViewController,
        UITableViewDelegate,
        UITableViewDataSource,
        AdresaProtocol {
    
    var restaurants: [StorePOJO] = []
    var popupAddress: AdressPopupViewController? = nil
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        return screenHeight/3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let categories:CategoriesCollectionViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CategoriesCollectionViewController") as! CategoriesCollectionViewController

        let sp: StorePOJO = restaurants[indexPath.row]
        MySession.selStoreId = String(sp.id ?? 0)
        categories.selCat = ""
        categories.storeId = "" + String(sp.id!)
        let token:String = (UserDefaults.standard.value(forKey: kUDToken) ?? "") as! String
        let parameters:[String: String] = ["firebase_uid": token,
                                           "store_id": String(sp.id!)]
        
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
                                    
        })
        self.navigationController?.pushViewController(categories, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return restaurants.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellStore:StoreTableViewCell = tableView.dequeueReusableCell(withIdentifier: "StoreTableViewCell", for: indexPath) as! StoreTableViewCell
        
        let sp: StorePOJO = restaurants[indexPath.row]
        
        cellStore.storePOJO = sp
        //cell.imgLogo.image = UIImage(named: "basket")
        return cellStore

    }
    

    @IBOutlet weak var tableViewStores: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    
    @objc private func addressClicked() {
        print(#function)
        self.popupAddress = UIStoryboard(name: "Address", bundle: nil).instantiateViewController(
                      withIdentifier: "AdressPopupViewController")
                      as! AdressPopupViewController
        popupAddress?.modalPresentationStyle = .overCurrentContext
        popupAddress?.adresaProtocol = self
        self.present(popupAddress!, animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        MySession.loadCart()
        
        let imageLogo = UIImage(named: "combo")
            // let imageView = UIImageView(image:imageLogo)
        self.setTitleEx("Adresa si inca ", andImage: imageLogo!, target: self, #selector(addressClicked))
        
        self.title = "Stores"
        tableViewStores.delegate = self
        tableViewStores.dataSource = self
        tableViewStores.backgroundColor = UIColor.selgrosBackground
        tableViewStores.separatorStyle = .none
        
        
        let token:String = (UserDefaults.standard.value(forKey: kUDToken) ?? "") as! String 
        let parameters:[String: String] = ["firebase_uid": token]
        WebWrapper.shared.callAPI(reqType:API_GET_STORES,
                                  parameters: parameters,
                                  methodType: .post,
                                  showLoader: false,
                                  completion: { (responseType, response, error) in
            
            print("call done")
            let reqResponse: RRestaurantsResponse = RRestaurantsResponse(JSONString: response ?? "")!
            self.restaurants = reqResponse.restaurants ?? []
            
            self.tableViewStores.reloadData()
                    
            })
        
        makeup()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func makeup(){
        
        var imageLeft = UIImage(named: "hamburger")
        imageLeft = imageLeft?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:imageLeft , style: UIBarButtonItem.Style.plain, target: self, action: #selector(showBurger(sender:)))
        
    }
    
    @objc func showBurger(sender: AnyObject) {
        let sideController:SideTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sideViewController") as! SideTableViewController
        let menu = SideMenuNavigationController(rootViewController: sideController)
        menu.leftSide = true
        // SideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration
        // of it here like setting its viewControllers. If you're using storyboards, you'll want to do something like:
        // let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
    }
    // MARK: - Table view data source

  
    func addNewAddress() {
        
        if let pa = self.popupAddress {
            pa.dismiss(animated: true) {
                
            let address:NewAddressViewController = UIStoryboard(name: "Address", bundle: nil).instantiateViewController(withIdentifier: "NewAddressViewController") as! NewAddressViewController

            self.navigationController?.pushViewController(address, animated: true)

            }
        }
    }


}
