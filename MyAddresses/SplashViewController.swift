//
//  SplashViewController.swift
//  MyAddresses
//
//  Created by AMIT on 9/6/18.
//  Copyright © 2018 com.amitdsdsdsds. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var splaImageV: UIImageView!
    @IBOutlet weak var imageBotCon: NSLayoutConstraint!
    @IBOutlet weak var myAddLbl: UILabel!
    @IBOutlet weak var lblTopCon: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        imageBotCon.constant = self.view.frame.height / 2 + splaImageV.frame.height / 2
        
        lblTopCon.constant = -1 * self.view.frame.height / 2 + splaImageV.frame.height / 2 + 20
        
        UIView.animate(withDuration: 1, animations: {
            
              self.view.layoutIfNeeded()
            
        }) { (animated) in
            
            if UserDefaults.standard.bool(forKey: "KIsLogged")
            {
                let sideController = self.storyboard?.instantiateViewController(withIdentifier: "Tab")
                
                let nav = UINavigationController(rootViewController:sideController!)
                
                nav.navigationBar.isHidden = true
                
                UIApplication.shared.keyWindow!.rootViewController = nav
                
            }
            else {
                
                let sideController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
                
                UIApplication.shared.keyWindow!.rootViewController = sideController!
            }
        }
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
