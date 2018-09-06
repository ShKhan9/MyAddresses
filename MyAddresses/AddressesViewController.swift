//
//  AddressesViewController.swift
//  MyAddresses
//
//  Created by AMIT on 9/6/18.
//  Copyright © 2018 com.amitdsdsdsds. All rights reserved.
//

import UIKit
import CoreLocation
class AddressesViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var noItemsLbl: UILabel!
    
    @IBOutlet weak var areaSettTable: UITableView!
   
    var dataDef = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       noItemsLbl.isHidden = Service.shared.items.count != 0
        
        areaSettTable.delegate=self
        
        areaSettTable.dataSource=self
   
        areaSettTable.bounces = false
        
        areaSettTable.separatorStyle = .none
        
        areaSettTable.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        
        areaSettTable.isOpaque = true
        
        areaSettTable.estimatedRowHeight = 200
        
        areaSettTable.rowHeight = UITableViewAutomaticDimension
        
        areaSettTable.register(UINib.init(nibName: "AddreTableViewCell", bundle: nil), forCellReuseIdentifier: "cellID")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.areaSettTable.reloadData()
        
         noItemsLbl.isHidden = Service.shared.items.count != 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  Service.shared.items.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = areaSettTable.dequeueReusableCell(withIdentifier:"cellID") as! AddreTableViewCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        let item = Service.shared.items[indexPath.row]
        
        cell.nameLbl.text = item.name
        
        cell.descLbl.text = item.des
        
        cell.layoutIfNeeded()
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = Service.shared.items[indexPath.row]
        
        let home = self.tabBarController!.viewControllers![0] as! HomeViewController
        
        self.tabBarController?.selectedIndex = 0
        
        home.zoomTo(CLLocationCoordinate2D.init(latitude: item.lat, longitude: item.lon))
        
    
        
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

class Item {
    
    
    var name:String = ""
    
    var des:String = ""
    
    var lat:Double
    
    var lon:Double
    
    init(lat:Double,lon:Double){
        
        self.lat = lat
        
        self.lon = lon
        
     
    }
    func gecode(completion:@escaping()-> Void)
    {
        
        let location = CLLocation(latitude: self.lat, longitude: self.lon)
        
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            if(error != nil)
            {
                return
            }
            
            if let placeMark = placemarks?[0] {
           
                
                // Country
                if let country = placeMark.addressDictionary!["Country"] as? String {
                    
                    self.des = country + ","
                    
                    print("Country \(country)")
                    
                }
                
                // City
                if let city = placeMark.addressDictionary!["City"] as? String {
                 
                     self.des += "\(city) , "
                    
                    print("city \(city)")
                    
                }
                
                // Location name
                if let SubLocality = placeMark.addressDictionary!["SubLocality"] as? String {
                   
                      self.des += "\(SubLocality) , "
                    
                    print("SubLocality \(SubLocality)")
                }
                
                // Street address
                if let street = placeMark.addressDictionary!["Thoroughfare"] as? String {
                    
                      self.des += "\(street) , "
                    
                    print("street \(street)")
                    
                }
                
                
                // Location name
                if let locationName = placeMark.addressDictionary!["Name"] as? String {
                 
                    self.name = locationName
                    
                    print("locationName \(locationName)")
                    
                }
                completion()
            }
            
            
        })
        
    }
}

class Service {
    
    static let shared = Service()
    
    var items = [Item]()
     
}


