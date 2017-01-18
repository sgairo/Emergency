//
//  HomeModel.swift
//  Emergency
//
//  Created by Sophie Gairo on 11/12/16.
//  Copyright © 2016 Sophie Gairo. All rights reserved.
//

import Foundation
protocol HomeModelProtocal: class {
    func itemsDownloaded(items: NSArray)
}


class HomeModel: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: HomeModelProtocal!
    
    var data : NSMutableData = NSMutableData()
    
    let urlPath: String = "http://seniorproject.sophiegairo.com/service.php"
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
        let users: NSMutableArray = NSMutableArray()
        var flag2: Bool
        for i in 0..<jsonResult.count{

            print(jsonResult[i])
            
            jsonElement = jsonResult[i] as! NSDictionary

            let user = UserModel()
            
            //the following insures none of the JsonElement values are nil through optional binding
                let username = jsonElement["username"] as? String
                let password = jsonElement["password"] as? String
                let email = jsonElement["email"] as? String
                flag2 = ((jsonElement["flag"] as? Bool) != nil)
            
                if flag2
                {
                    flag2 = true
                }
                else{
                     flag2 = false
                }
                let timestamp = jsonElement["timestamp"] as? String
            //{
                
            
                user.username = username!
                user.password = password!
                user.email = email!
                user.flag = flag2
                user.timestamp = timestamp!
                
            //}
            
            users.add(user)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(items: users)
            
        })
    }
    
    
    
    
    
    
    
    
    
    
    
    


}
