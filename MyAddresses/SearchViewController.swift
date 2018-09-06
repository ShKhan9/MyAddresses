//
//  SearchViewController.swift
//  MyAddresses
//
//  Created by AMIT on 9/6/18.
//  Copyright © 2018 com.amitdsdsdsds. All rights reserved.
//

import UIKit

import GooglePlaces

class SearchViewController: UIViewController  , UITableViewDelegate , UITableViewDataSource , UITextFieldDelegate {

    @IBOutlet weak var cancelBu: UIButton!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var areaSettTable: UITableView!
    
    var dataDef = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.textfield.delegate = self
        
        areaSettTable.delegate=self
        
        areaSettTable.dataSource=self
        
        // areaSettTable.backgroundColor = UIColor.red
        
        areaSettTable.bounces = false
        
        areaSettTable.separatorStyle = .none
        
        areaSettTable.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        
        areaSettTable.isOpaque = true
        
        areaSettTable.estimatedRowHeight = 120
        
        areaSettTable.rowHeight = UITableViewAutomaticDimension
        
        self.textfield.addTarget(self, action: #selector(self.textFieldDidChange(_:)),
                            for: .editingChanged)
        
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
          self.textfield.becomeFirstResponder()
        
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        
 
        cancelBu.isHidden = false
        
        search(textfield.text!)
        
    
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  dataDef.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = areaSettTable.dequeueReusableCell(withIdentifier:"cellID") as! SearTableViewCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
  
        cell.searLbl.text = dataDef[indexPath.row]
         
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
 
    func search(_ searchText: String){
        
        print(searchText)
        
        let placesClient = GMSPlacesClient()
        let f = GMSAutocompleteFilter()
        f.country = "eg"
        placesClient.autocompleteQuery(searchText, bounds: nil, filter: f) { ( results , error) in
         
            print(error)
            
            if error != nil {
                
                return
            }
            
            
            if searchText != self.textfield.text {
                
                return
            }
            
            self.dataDef.removeAll()
      
            for result in results!{
               
                    self.dataDef.append(result.attributedFullText.string)
               
            }
            self.areaSettTable.reloadData()
        }
    }
    @IBAction func cancelClicked(_ sender: Any) {
        
        cancelBu.isHidden = true
        
        textfield.text = ""
  
        dataDef.removeAll()
        
        areaSettTable.reloadData()
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
