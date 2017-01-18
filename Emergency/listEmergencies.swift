//
//  listEmergencies.swift
//  Emergency
//
//  Created by Sophie Gairo on 12/6/16.
//  Copyright © 2016 Sophie Gairo. All rights reserved.
//

import UIKit

class listEmergencies: UIViewController, UITableViewDataSource, UITableViewDelegate, EmergencyModelProtocal{


    let loc = GetLocation()
    var city: String?
    var state: String?
    var cities = ["test"]
    var states = ["test"]
    var ids = ["test"]
    var SelectedUser: String?
    var feedItems: NSArray = NSArray()
    var selectedEmergency : Emergency = Emergency()
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loc.getAdress { result in
            
            self.city = result["City"] as? String
            
            
            self.state = result["State"] as? String
            
            
        }
        let emergencyModel = EmergencyModel()
        emergencyModel.delegate = self
        emergencyModel.downloadItems()
        

        tableview.dataSource = self
        tableview.delegate = self
    
        
    }
    
    func itemsDownloaded(items: NSArray) {
        
        feedItems = items
        for i in 0..<feedItems.count{

            let item: Emergency = feedItems[i] as! Emergency
            print((item.city!))
            print(city)
            print (item.city == city)
            
           // if(item.city == city && item.state == state) {
                //put into table cell
                ids.insert(item.id!, at:i)
                cities.insert(item.city!, at:i)
                states.insert(item.state!, at:i)
                //cell.idValue_lbl.text = String(describing: item.id!)
                //cell.cityValue_lbl.text = item.city!
                //cell.stateValue_lbl.text = item.state!
            //}
            
        }

        tableview.reloadData()
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            // Put your code which should be executed with a delay here
      

        print("in table view")
        //var cell = UITableViewCell() as! AleTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmergencyEvents", for: indexPath) as! EmergencyListCell
        
               print(self.ids.count)
        
 
                cell.idValue_lbl.text = self.ids[indexPath.item]
                cell.cityValue_lbl.text = self.cities[indexPath.item]
                cell.stateValue_lbl.text = self.states[indexPath.item]
            
        
       
        return cell
        
           
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return ids.count
        }
        else
        {
            return 10//number of color accents
        }
    }
    
    
    
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    



     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
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
