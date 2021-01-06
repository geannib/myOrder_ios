//
//  SceneDelegate.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 6/10/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import UIKit
import GoogleSignIn
import FirebaseAuth
import Firebase

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private(set) static var shared: SceneDelegate?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
               //GIDSignIn.sharedInstance().delegate = self

               let navCtrl = UINavigationController();
               if(GIDSignIn.sharedInstance().hasPreviousSignIn()) {

                   let signIn = GIDSignIn.sharedInstance()
                   signIn?.scopes = ["https://www.googleapis.com/auth/plus.login","https://www.googleapis.com/auth/plus.me"]

                   GIDSignIn.sharedInstance()?.restorePreviousSignIn()

//                   let aa = Auth.auth()
//                   let uid = aa.currentUser?.uid
//                   UserDefaults.standard.set(uid, forKey: kUDToken)
                   

               }
        guard let _ = (scene as? UIWindowScene) else { return }
        Self.shared = self
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        computeFirstFlow()
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    func computeFirstFlow(){
        
        let navCtrl = UINavigationController();
        navCtrl.navigationBar.barTintColor = UIColor.selgrosRed
        navCtrl.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.selgrosWhite]
        if #available(iOS 13.0, *) {
            UINavigationBar.appearance().barTintColor = UIColor.selgrosRed
            UINavigationBar.appearance().tintColor = UIColor.selgrosWhite
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            UINavigationBar.appearance().isTranslucent = false
        }
        
        // User is not logged in
        if (UserDefaults.standard.value(forKey: kUDToken) == nil){
           
            let login = LoginViewController.loadController()
            navCtrl.viewControllers = [login]
        }
            // Phone was not set
        else if (UserDefaults.standard.value(forKey: kIsPhoneCodSet) == nil){
            
            let phone = PhoneViewController.loadController()
            navCtrl.viewControllers = [phone]
        }
            // Licence agreement was not set
        else if (UserDefaults.standard.value(forKey: kIsLASet) == nil){
            
            let agreement = AgreementViewController.loadController()
            navCtrl.viewControllers = [agreement]
        }
        else{
            
            let stores = StoresViewController.loadController()
            navCtrl.viewControllers = [stores]
        }
        
       window?.rootViewController = navCtrl
       window?.makeKeyAndVisible()
       
    }


}

