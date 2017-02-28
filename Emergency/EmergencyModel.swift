//
//  EmergencyModel.swift
//  Emergency
//
//  Created by Sophie Gairo on 12/6/16.
//  Copyright © 2016 Sophie Gairo. All rights reserved.
//

import Foundation
protocol EmergencyModelProtocal: class {
    func itemsDownloaded(items: NSArray)
}


class EmergencyModel: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: EmergencyModelProtocal!
    
    var data : NSMutableData = NSMutableData()
    
    let urlPath: String = "http://seniorproject.sophiegairo.com/getEmergency.php"
    //this will be changed to the path where service.php lives
    
    
    func downloadItems() {
        
        let url: NSURL = NSURL(string: urlPath)!
        var session: URLSession!
        let configuration = URLSessionConfiguration.default
        
        
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        
        let task = session.dataTask(with: url as URL)
        
        task.resume()
        
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        self.data.append(data as Data);
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error != nil {
            print("Failed to download data")
        }else {
            print("Data downloaded")
            self.parseJSON()
        }
        
    }
    
    
    func parseJSON() {
        
        var jsonFixer: NSArray = NSArray()
        var jsonResult: NSMutableArray = NSMutableArray()
        
        do{
            
            jsonFixer = try JSONSerialization.jsonObject(with: self.data as Data, options: .allowFragments) as! NSArray
            jsonResult = NSMutableArray(array: jsonFixer)
            
        } catch let error as NSError {
            
            print(error)
        }
        
        var jsonElement: NSDictionary = NSDictionary()
        let emergencies: NSMutableArray = NSMutableArray()
        //var flag2: Bool
        for i in 0..<jsonResult.count{
            
            print(jsonResult[i])
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let emergency = Emergency()
            
            //the following insures none of the JsonElement values are nil through optional binding
            
            let id = jsonElement["id"] as? String
            let city = jsonElement["city"] as? String
            let state = jsonElement["state"] as? String
            let zip = jsonElement["zip"] as? String
            let deviceName = jsonElement["deviceName"] as? String
            
            print("id= ",id, " city= ", city, " state= ",state, "zip= ",zip, "Device Name= ",deviceName)
            emergency.id = id!
            emergency.city = city!
            emergency.state = state!
            emergency.zip = zip!
            emergency.deviceName = deviceName!
            
            emergencies.add(emergency)
            print(emergencies.count)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(items: emergencies)
            print("after delegate")
            
        })
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
