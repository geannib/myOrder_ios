//
//  AgreementViewController.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 12/30/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import UIKit
import WebKit

class AgreementViewController: UIViewController {

    @IBOutlet weak var labelNext: UILabel!
    @IBOutlet weak var webkitAgreement: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        makeup()
        handleEvents()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Termeni si conditii"
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    
    func handleEvents(){
           
           labelNext.isUserInteractionEnabled = true
           let tapNext = UITapGestureRecognizer(target: self, action:  #selector (self.nextTapped (_:)))
           tapNext.numberOfTapsRequired = 1
           labelNext.addGestureRecognizer(tapNext)
    }

    func makeup(){
    
        view.backgroundColor = .selgrosGray
        labelNext.backgroundColor = .selgrosRed
        labelNext.generateAttributedString(fonts: ["Roboto-Bold"],
            colors: [.selgrosWhite],
            sizes: [20],
            texts: ["CONTINUARE"],
            alignement: .center)
        
        let link = URL(string:"https://www.dozo.ro/terms-and-conditions.html")!
        let request = URLRequest(url: link)
        webkitAgreement.load(request)
    }
    
    @objc func nextTapped(_ sender:UITapGestureRecognizer){
           
        UserDefaults.standard.set(true, forKey: kIsLASet)
        
        if #available(iOS 13.0, *) {

            SceneDelegate.shared?.computeFirstFlow()

        } else {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.computeFirstFlow()

        }
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
