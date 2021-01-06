//
//  StoresViewControllerTableViewController.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 11/16/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import UIKit
import FirebaseAuth


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
        
        let cell:StoreTableViewCell = tableView.dequeueReusableCell(withIdentifier: "StoreTableViewCell", for: indexPath) as! StoreTableViewCell
        
        let sp: StorePOJO = restaurants[indexPath.row]
        
        let token:String = (UserDefaults.standard.value(forKey: kUDToken) ?? "") as! String
        let imgURL = API_GET_STORE_IMAGE + "?id=" + String(sp.id!) + "&firebase_uid=" + token;
//        imgURL = "https://i2.wp.com/ceklog.kindel.com/wp-content/uploads/2013/02/firefox_2018-07-10_07-50-11.png"
        //imgURL = ""
        cell.labelName.text = sp.name
        cell.labelOrar.text = sp.openHour! + "-" + sp.closeHour!
        cell.labelType.text = sp.label!
        cell.labelOpen.text = "Open"
        cell.labelTaxaTitle.text = "Colectare livrare:"
        cell.labelTaxaValue.text = sp.orderFee
        cell.labelValoareTitle.text = "Comanda minima:"
        cell.labelValoareValue.text = sp.minimumOrder
        cell.labelTimpTitle.text = "Timp livrare:"
        cell.labelTimpValue.text = sp.deliveryTime
        cell.imgLogo.sd_setImage(with: URL(string: imgURL), placeholderImage: nil)
        //cell.imgLogo.image = UIImage(named: "basket")
        return cell

    }
    

    @IBOutlet weak var tableViewStores: UITableView!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let imageLogo = UIImage(named: "logo")
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
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
