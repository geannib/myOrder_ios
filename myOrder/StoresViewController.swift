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


class StoresViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var restaurants: [StorePOJO] = []
    
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
    override func viewDidLoad() {
        super.viewDidLoad()

        MySession.loadCart()
        
        let imageLogo = UIImage(named: "plus")
            // let imageView = UIImageView(image:imageLogo)
        self.setTitleEx("Adresa ", andImage: imageLogo!)
        
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

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
