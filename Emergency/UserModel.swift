//
//  UserModel.swift
//  Emergency
//
//  Created by Sophie Gairo on 11/12/16.
//  Copyright © 2016 Sophie Gairo. All rights reserved.
//

import Foundation

class UserModel: NSObject {
    
    //properties
    
    var username: String?
    var password: String?
    var email: String?
    var flag: Bool?
    var timestamp: String?
    
    
    //empty constructor
    
    override init()
    {

    }
    
    //construct with parameters
    
    init(theusername: String, thepassword: String, theemail: String, theflag: Bool, thetimestamp: String) {
        
        self.username = theusername
        self.password = thepassword
        self.email = theemail
        self.flag = theflag
        self.timestamp = thetimestamp
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "Name: \(username), Password: \(password), Email: \(email), Flag: \(flag), Timestamp: \(timestamp)"
        
    }
    
    
}
