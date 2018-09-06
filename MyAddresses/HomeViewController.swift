//
//  HomeViewController.swift
//  MyAddresses
//
//  Created by AMIT on 9/6/18.
//  Copyright © 2018 com.amitdsdsdsds. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
class HomeViewController: UIViewController , GMSMapViewDelegate , CLLocationManagerDelegate  {
    
    @IBOutlet weak var mapView: GMSMapView!
    let locationManager = CLLocationManager()

    var getOnce = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        mapView.delegate = self
        
        locationManager.delegate = self
     
        locationManager.requestAlwaysAuthorization()
        
        locationManager.startUpdatingLocation()
    }

    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
     
        
        let last = Service.shared.items.count
     
        let st =  Item(lat: coordinate.latitude, lon: coordinate.longitude)
        
        Service.shared.items.append(st)
        
        Utilities.addHoverView(v: self.view)

        st.gecode {
            
            let position = CLLocationCoordinate2D(latitude:coordinate.latitude, longitude:coordinate.longitude)
            let marker  = GMSMarker(position: position)
            marker.icon = UIImage.init(named: "location_icon.png")
            marker.title = st.name
            marker.map = mapView
            marker.snippet = st.des
            marker.isDraggable = true
            
            Utilities.removeHoverView(vd: self.view)
        }
        
    }
    //this method is called by the framework on   locationManager.requestLocation();
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Did location updates is called")
        //store the user location here to firebase or somewhere
        
        let loc = locations.last
    
        if(getOnce)
        {
            zoomTo(loc!.coordinate)
            
            getOnce = false
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Did location updates is called but failed getting location \(error)")
    }
    func zoomTo(_ cllo:CLLocationCoordinate2D) {
        
        self.mapView.camera = GMSCameraPosition(target:cllo, zoom: 15, bearing: 0, viewingAngle: 0)
        
        
    }
    func gecode(location:CLLocation)
    {
        
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            if(error != nil)
            {
                return
            }
            
            if let placeMark = placemarks?[0] {
                
                if let country = placeMark.addressDictionary!["Country"] as? String {
                    
                    if country == "Egypt" {
                        
                        print("hbjdcbhsbhjcbhsbhjcasbhkcbhdskbchdsc")
                    }
                    
                }
           
            
            // Country
            if let country = placeMark.addressDictionary!["Country"] as? String {
                
              
                
                print("Country \(country)")
                
            }
            
            // City
            if let city = placeMark.addressDictionary!["City"] as? String {
                print("City \(city)")
                
              
                print("city \(city)")
                
            }
            
            // Location name
            if let SubLocality = placeMark.addressDictionary!["SubLocality"] as? String {
                print("SubLocality132 \(SubLocality)")
                
              
                print("SubLocality \(SubLocality)")
            }
            
            // Location name
            if let locationName = placeMark.addressDictionary!["Name"] as? String {
                print(locationName)
                
              
                print("locationName \(locationName)")
                
            }
            
            // Street address
            if let street = placeMark.addressDictionary!["Thoroughfare"] as? String {
                print(street)
                
                
                print("street \(street)")
                
            }
            
            }
             
        })
        
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
