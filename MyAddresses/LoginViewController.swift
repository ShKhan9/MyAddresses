//
//  LoginViewController.swift
//  MyAddresses
//
//  Created by AMIT on 9/6/18.
//  Copyright © 2018 com.amitdsdsdsds. All rights reserved.
//

import UIKit

import GoogleSignIn
    
class LoginViewController: UIViewController ,GIDSignInDelegate, GIDSignInUIDelegate{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().scopes.append("https://www.googleapis.com/auth/plus.stream.read")
        GIDSignIn.sharedInstance().scopes.append("https://www.googleapis.com/auth/plus.me")
        GIDSignIn.sharedInstance().hasAuthInKeychain()

        
    }

    @IBAction func emailClicked(_ sender: Any) {
        
        if(!Utilities.isNetworkAvailable())
        {
            Utilities.showAlert(inVC: self, message: "No Internet Connection....")
            return
        }
        
        Utilities.addHoverView(v: self.view)
        
        GIDSignIn.sharedInstance().signOut()
        
        GIDSignIn.sharedInstance().signIn()
        
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        
        Utilities.addHoverView(v: self.view)
        
        Utilities.showAlert(inVC: self, message: "Error in sign with google + ")
        // ...
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        
        if error != nil
        {
            
            Utilities.removeHoverView(vd: self.view)
            
            return
        }
        
        let email = user.profile.email
        let  fullName = user.profile.name;
     
        Utilities.removeHoverView(vd: self.view)
        
        
        guard let em = email , let fName = fullName else {
            
          Utilities.showAlert(inVC: self, message: "No email address")
            
            return
            
        }
        
        UserDefaults.standard.set(em, forKey: "KEmail")
        
        UserDefaults.standard.set(fName, forKey: "KFullName")
        
        UserDefaults.standard.set(true, forKey: "KIsLogged")
        
        let sideController = self.storyboard!.instantiateViewController(withIdentifier: "Tab")
        
        let nav = UINavigationController(rootViewController:sideController)
        
        nav.navigationBar.isHidden = true
        
        UIApplication.shared.keyWindow!.rootViewController = nav
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
