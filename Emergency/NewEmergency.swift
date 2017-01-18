//
//  NewEmergency.swift
//  Emergency
//
//  Created by Sophie Gairo on 12/6/16.
//  Copyright © 2016 Sophie Gairo. All rights reserved.
//

import UIKit

class NewEmergency: UIViewController {
    let loc = GetLocation()
    var city: String?
    var state: String?
    var SelectedUser:String?
    
    
    
    @IBOutlet weak var user_lbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loc.getAdress { result in
            
            self.city = result["City"] as? String
            
            
            self.state = result["State"] as? String
            
            
        }
        
        user_lbl.text = SelectedUser
    }
    
    @IBAction func addEmergency(_ sender: UIButton) {
        
        //TO DO: check if flag is 1, thus user cant post emergency, for now just leave it as is.
        
        
        var request = URLRequest(url: URL(string:"http://seniorproject.sophiegairo.com/newEmergency.php")!)
        request.httpMethod = "POST"
        let postString = "city=\(city)&state=\(state)"
        
        print(postString)
        request.httpBody = postString.data(using: .utf8)
        
        
        
        
        
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
