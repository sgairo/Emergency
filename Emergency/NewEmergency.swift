//
//  NewEmergency.swift
//  Emergency
//
//  Created by Sophie Gairo on 12/6/16.
//  Copyright © 2016-2017 Sophie Gairo. All rights reserved.
//

import UIKit

class NewEmergency: UIViewController {
    let loc = GetLocation()
    var city: String!
    var state: String!
    var zip: String!
    var SelectedUser: String?
    
    
    
    @IBOutlet weak var user_lbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loc.getAdress { result in
            
            
            self.city = (result["City"] as? String)!
            
            self.zip = (result["ZIP"] as? String)!
            self.state = (result["State"] as? String)!
            
            
        }
        
        //print(SelectedUser!)
        user_lbl.text = SelectedUser
    }
    
    @IBAction func addEmergency(_ sender: UIButton) {
        
        //TO DO: check if flag is 1, thus user cant post emergency, for now just leave it as is.
        
        //if available through internet, send, otherwise store in local memory and find a way to constantly check for internet
        
        var request = URLRequest(url: URL(string:"http://seniorproject.sophiegairo.com/newEmergency.php")!)
        request.httpMethod = "POST"
        let postString = "city=\(city!)&state=\(state!)&zip=\(zip!)"
        
        print(postString)
        request.httpBody = postString.data(using: .utf8)
        
        
        
        
        //maybe if http status code is 500 then do a Retry-After
        let task = URLSession.shared.dataTask(with: request) { data, response, error in guard let data = data, error == nil else {
            print("error=\(error)")
            return
            }
            
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200 ")
                print("response = \(response)")
                
                
            }
            let responseString = String(data: data, encoding: .utf8)
        }//end let
        task.resume()
        
        self.performSegue(withIdentifier: "newEmergencyToEmergencyNearUser", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        
        if segue.identifier == "newEmergencyToEmergencyNearUser"{
            
            
            let destination = segue.destination as? listEmergencies
            
            destination?.SelectedUser = SelectedUser
        }
    }

    
    
    
    
    
}
