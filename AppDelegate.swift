//
//  AppDelegate.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 6/10/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import UIKit
import Firebase
import SideMenu
import GoogleSignIn
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

var window: UIWindow?

    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
      -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
         FirebaseApp.configure()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self

           let navCtrl = UINavigationController();
         if(GIDSignIn.sharedInstance().hasPreviousSignIn()) {
            
             let signIn = GIDSignIn.sharedInstance()
            signIn?.scopes = ["https://www.googleapis.com/auth/plus.login","https://www.googleapis.com/auth/plus.me"]

            GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
            
            //if let usr = GIDSignIn.sharedInstance()?.currentUser{
//                guard let token = usr.authentication.accessToken else { return true }
//                print("token in delegate: " + token)
//
               let aa = Auth.auth()
               let uid = aa.currentUser?.uid
                UserDefaults.standard.set(uid, forKey: kUDToken)
            let stores = StoresViewController.loadController()
            navCtrl.viewControllers = [stores]
//            let parameters:[String: String] = ["firebase_uid": uid ?? ""]
//                WebWrapper.shared.callAPI(reqType:API_GET_STORES,
//                                                parameters: parameters,
//                                                methodType: .post,
//                                                showLoader: false,
//                                                completion: { (responseType, response, error) in
//
//                          print("call done")
//                        if (error != nil){
//
//                            print("We got error on call API_GET_STORES \(error?.localizedDescription)")
//
//                        }else{
//
//
//                        }
//
//                          })
            //}
           
            
         
            
         } else{
            
         
             let login = LoginViewController.loadController()
             navCtrl.viewControllers = [login]
             
         
        }
        
        navCtrl.navigationBar.barTintColor = UIColor.selgrosRed
        navCtrl.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        window?.rootViewController = navCtrl
        window?.makeKeyAndVisible()
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle
@available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
@available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
      // ...
      if let error = error {
        // ...
        return
      }

      guard let authentication = user.authentication else { return }
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                        accessToken: authentication.accessToken)
      
       
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }

}

