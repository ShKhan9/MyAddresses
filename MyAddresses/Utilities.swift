//
//  Utilities.swift
//  Yachts
//
//  Created by AMIT IOS Developer on 3/11/18.
//  Copyright © 2018 com.AmitSoftware. All rights reserved.
//

import UIKit
import SVProgressHUD
import SystemConfiguration

 
class Utilities {
    
    
    class func showAlert(inVC:UIViewController , message:String)
    {
        
        let alert = UIAlertController(title: nil , message: message , preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        inVC.present(alert, animated: true)
    }
    class func showHud2(vd:UIView)
    {
        let hover = UIView()
        
        hover.tag = 120
        
        hover.frame = vd.frame
        
        vd.addSubview(hover)
        
        SVProgressHUD.show()
        
    }
    class func hideHud2(vd:UIView)
    {
        for v in vd.subviews
        {
            if(v.tag==120)
            {
                v.removeFromSuperview()
            }
        }
        
        SVProgressHUD.dismiss()
        
    }
    
    class func showAlertHome(message:String)
    {
        
        let alert = UIAlertController(title: nil , message: message , preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true)
    }
    /**
     ## adds hover view to main window when app requests data from server. ##
     
     - Parameter v: v is the parent view where hover view should be added.
     
     */
    
    class func addHoverView(v:UIView)
    {
        
        let hover = UIView()
        
        hover.tag = 120
        
        hover.frame = v.frame
        
        v.addSubview(hover)
        
        hover.center = v.center
        
        hover.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        let act = UIActivityIndicatorView()
        
        act.center = hover.center
        
        hover.addSubview(act)
        
        act.startAnimating()
    }
    
    /**
     ## removes hover view from main window when app finishes getting the data. ##
     
     - Parameter v: v is the parent view where hover view should be removed.
     
     */
    
    class func removeHoverView(vd:UIView)
    {
        for v in vd.subviews
        {
            if(v.tag==120)
            {
                v.removeFromSuperview()
            }
        }
    }
    
  
  
  
    class func hideHud(vd:UIView)
    {
        for v in vd.subviews
        {
            if(v.tag==120)
            {
                v.removeFromSuperview()
            }
        }
        
        SVProgressHUD.dismiss()
        
    }
    
  
    
    class func isNetworkAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                zeroSockAddress in SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)}
        } ) else {
            return false
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags)
        {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    

}
