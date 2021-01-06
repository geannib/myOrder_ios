//
//  SideTableViewController.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 6/19/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import UIKit

class SideTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.separatorStyle = .none
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0){
            return 120
        }else{
            return 59
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var rowsCnt = 0
        if (section == 0){
            rowsCnt = 1
        }
        else if (section == 1) {
            rowsCnt = 7
        }
        else if (section == 2){
            rowsCnt = 5
        }
        
        return rowsCnt
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            let cell:SideTableHeaderCellTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "SideTableHeaderCellTableViewCell", for: indexPath) as? SideTableHeaderCellTableViewCell
            
            cell?.labelTitle?.text = "Nume utilizator"
            return cell!
            
        }
        if(indexPath.section == 1){
            
            var txt = ""
            let cell:SideTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "SideTableViewCell", for: indexPath) as? SideTableViewCell
            switch indexPath.row {
            case 0:
                txt = "Comenzile mele"
                break;
                case 1:
                txt = "Adresele mele"
                break;
                case 2:
                txt = "Produsele mele"
                break;
                case 3:
                txt = "Informatii personale"
                break;
                case 5:
                txt = "Invita un prieten "
                break;
                case 6:
                txt = "Ajutor "
                break;
            default:
                txt = "NA"
            }
            
            cell?.labelTitle?.generateAttributedString(fonts: ["Roboto-Bold"],
            colors: [.black],
            sizes: [15],
            texts: [txt],
            alignement: .left)
            
            
            return cell!
            
        }
        if(indexPath.section == 2){
            
            let cell:SideTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "SideTableViewCell", for: indexPath) as? SideTableViewCell
            
            var txt = ""
            switch indexPath.row {
            case 0:
                txt = "Termeni si conditii"
                break;
                case 1:
                txt = "Politica de confidentialitate"
                break;
                case 2:
                txt = "Retur"
                break;
                case 3:
                txt = "ANPC"
                break;
                case 4:
                txt = "Logout"
                break;
               
            default:
                txt = "NA"
            }
            
            cell?.labelTitle?.generateAttributedString(fonts: ["Roboto-Bold"],
            colors: [.black],
            sizes: [15],
            texts: [txt],
            alignement: .left)
            
            return cell!
        }
        
        return UITableViewCell()
    }
    

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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        print("row \(indexPath.row) was selected")
    }
}

