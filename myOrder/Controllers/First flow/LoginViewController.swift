//
//  LoginViewController.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 11/16/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseAuth

class LoginViewController: UIViewController, GIDSignInDelegate {
        
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
       
        if let error = error {
        // ...
            let alert = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (authResult, error) in

            let auth = Auth.auth()
            let uid = auth.currentUser?.uid
            UserDefaults.standard.set(uid, forKey: kUDToken)

            if #available(iOS 13.0, *) {

                SceneDelegate.shared?.computeFirstFlow()

            } else {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.computeFirstFlow()

            }

            print("User sign in")

        }
    }
     

//        let auth = Auth.auth()
//        let uid = auth.currentUser?.uid
//        UserDefaults.standard.set(uid, forKey: kUDToken)
        
//        let str:String = uid ?? ""
//        let alert = UIAlertController(title: "Alert", message: "SUccess: " + str, preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
        
       
       
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       GIDSignIn.sharedInstance().delegate = self
       GIDSignIn.sharedInstance()?.presentingViewController = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = ""
    }
    @IBAction func doLogare(_ sender: Any) {
   
        return;
        
        if(GIDSignIn.sharedInstance().hasPreviousSignIn()) {
        
            // Should never arrive here since it is tested in AppDelegate
             let stores = StoresViewController.loadController()
             self.navigationController?.pushViewController(stores, animated: true)
        } else {
        // present login screen here
       // GIDSignIn.sharedInstance().signIn()
        }
        
        return;
       if(GIDSignIn.sharedInstance().hasPreviousSignIn()) {

//            GIDSignIn.sharedInstance()?.restorePreviousSignIn()
//
//        
//            let stores = StoresViewController.loadController()
//            self.navigationController?.pushViewController(stores, animated: true)
        }else{
            GIDSignIn.sharedInstance().signIn()
        }
        
//        let firebaseAuth = Auth.auth()
//        do {
//          try firebaseAuth.signOut()
//        } catch let signOutError as NSError {
//          print ("Error signing out: %@", signOutError)
//        }
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
