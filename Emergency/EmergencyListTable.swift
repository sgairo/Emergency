//
//  EmergencyListTable.swift
//  Emergency
//
//  Created by Sophie Gairo on 12/6/16.
//  Copyright © 2016 Sophie Gairo. All rights reserved.
//
import UIKit
class EmergencyListTable: UITableViewController, EmergencyModelProtocal {
    
    let loc = GetLocation()
    var city: String?
    var state: String?
    
    var feedItems: NSArray = NSArray()
    var selectedEmergency : Emergency = Emergency()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loc.getAdress { result in
            
            self.city = result["City"] as! String
            
            
            self.state = result["State"] as! String
            
            
        }
        let emergencyModel = EmergencyModel()
        emergencyModel.delegate = self
        emergencyModel.downloadItems()
        
        print("IN EMERGENCTLISTTABLE , HEELLLLP")
    
        
        
    }
    
    func itemsDownloaded(items: NSArray) {
        
        feedItems = items
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            //var cell = UITableViewCell() as! AleTableViewCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmergencyEvents", for: indexPath) as! EmergencyListCell
    
            for i in 0..<feedItems.count{
                let item: Emergency = feedItems[i] as! Emergency
                print(item.city)
                print("matches", city)
                if(item.city == city && item.state == state) {
                    //put into table cell
                    cell.idValue_lbl.text = String(describing: item.id)
                    cell.cityValue_lbl.text = item.city
                    cell.stateValue_lbl.text = item.state
                }
            }

            
            return cell
        }

    
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
   }
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        
//        
//        
//        if segue.identifier == "allBeersEdit"{
//            
//            
//            let destination = segue.destination as? ViewController
//            let cell = sender as! UITableViewCell
//            let selectedRow = tableView.indexPath(for: cell)!.row
//            
//            destination?.SelectedValue = beerNames[selectedRow]
//        }
}
