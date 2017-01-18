//
//  NewUser.swift
//  Emergency
//
//  Created by Sophie Gairo on 12/6/16.
//  Copyright © 2016 Sophie Gairo. All rights reserved.
//


import UIKit

class NewUser: UIViewController, HomeModelProtocal {
    
    var feedItems: NSArray = NSArray()
    var selectedUser : UserModel = UserModel()
    
    @IBOutlet weak var username_txt: UITextField!

    @IBOutlet weak var password_txt: UITextField!
    
    @IBOutlet weak var email_txt: UITextField!
    
    @IBOutlet weak var error_lbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set delegates and initialize homeModel
        
        let homeModel = HomeModel()
        homeModel.delegate = self
        homeModel.downloadItems()
        
    }
    
    
    func itemsDownloaded(items: NSArray) {
        
        feedItems = items
        
        
    }
    
    
    
    
    @IBAction func submit_btn(_ sender: UIButton) {
        
        
 
      var validUser = true
    
      for i in 0..<feedItems.count{
                let item: UserModel = feedItems[i] as! UserModel
           if(item.username == username_txt.text) {
               error_lbl.text = "Username is already in use. Please try again."
               validUser = false
    
         }
    }
    if( validUser == true)
    {
// if validUser is true then submit into database , otherwise do nothing
        let datetime = Date()
        var request = URLRequest(url: URL(string:"http://seniorproject.sophiegairo.com/newUser.php")!)
        request.httpMethod = "POST"
        let postString = "username=\(username_txt.text!)&password=\(password_txt.text!)&email=\(email_txt.text!)&flag=0"
        
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
        self.performSegue(withIdentifier: "newUserToLogin", sender: self)

        }//end valid if
    
        
    
    }//sub button
    
    
}//end class





