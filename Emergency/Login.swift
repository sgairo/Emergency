//
//  Login.swift
//  Emergency
//
//  Created by Sophie Gairo on 11/12/16.
//  Copyright © 2016 Sophie Gairo. All rights reserved.
//
import UIKit

class Login: UIViewController, HomeModelProtocal {

    var feedItems: NSArray = NSArray()
    var selectedUser : UserModel = UserModel()
    
    @IBOutlet weak var username_txt: UITextField!
    
    @IBOutlet weak var password_txt: UITextField!
    
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
    
    
    @IBAction func login_btn(_ sender: UIButton) {
        
        let username_input = username_txt.text
        let password_input = password_txt.text
        var loginFail = true
        for i in 0..<feedItems.count{
           
            let item: UserModel = feedItems[i] as! UserModel
            if(item.username == username_input) && (item.password == password_input){
                //send to next screen
                self.performSegue(withIdentifier: "loginSuccess", sender: self)
                loginFail = false

            }
            
        }
        
        if loginFail{
            error_lbl.text = "Username or Password is incorrect. Please try again."
        }
        
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        
        if segue.identifier == "loginSuccess"{
            
            
            let destination = segue.destination as? NewEmergency
            destination?.SelectedUser = username_txt.text!
        }
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
}
