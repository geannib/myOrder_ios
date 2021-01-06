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
        
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
       
        
//        if(GIDSignIn.sharedInstance().hasPreviousSignIn()) {
//
//                  // GIDSignIn.sharedInstance()?.restorePreviousSignIn()
//
//               
//                   let stores = StoresViewController.loadController()
//                   self.navigationController?.pushViewController(stores, animated: true)
//            return
//        }
        if let error = error {
             // ...
             return
           }

           guard let authentication = user.authentication else { return }
        guard let userId = user.userID else {return}
           let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                             accessToken: authentication.accessToken)
    
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
          if let error = error {
            let authError = error as NSError
            if (authError.code == AuthErrorCode.secondFactorRequired.rawValue) {
              // The user is a multi-factor user. Second factor challenge is required.
              let resolver = authError.userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
              var displayNameString = ""
              for tmpFactorInfo in (resolver.hints) {
                displayNameString += tmpFactorInfo.displayName ?? ""
                displayNameString += " "
              }
              
            } else {
              //self.showMessagePrompt(error.localizedDescription)
              return
            }
            // ...
            return
          }
            
            print("User sign in")
    
          
            let auth = Auth.auth()
            let uid = auth.currentUser?.uid
            UserDefaults.standard.set(uid, forKey: kUDToken)
            let stores = StoresViewController.loadController()
             self.navigationController?.pushViewController(stores, animated: true)
          // User is signed in
          // ...
        }
    }
    

    @IBOutlet weak var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
       
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doLogare(_ sender: Any) {
   
        if(GIDSignIn.sharedInstance().hasPreviousSignIn()) {
        // Get new token from google and send to server
        //let strToken =  GIDSignIn.sharedInstance()?.
         let stores = StoresViewController.loadController()
         self.navigationController?.pushViewController(stores, animated: true)
        } else {
        // present login screen here
        GIDSignIn.sharedInstance().signIn()
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
