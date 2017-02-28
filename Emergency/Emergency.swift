//
//  Emergency.swift
//  Emergency
//
//  Created by Sophie Gairo on 12/6/16.
//  Copyright © 2016 Sophie Gairo. All rights reserved.
//

import Foundation
class Emergency: NSObject {
    
    //properties
    
    var id: String?
    var city: String?
    var state: String?
    var zip: String?
    var deviceName: String?
    
    //empty constructor
    
    override init()
    {
        id = ""
        city = ""
        state = ""
        zip = ""
        deviceName = ""
    }
    
    //construct with parameters
    
    init(theID: String, theCity: String, theState: String, theZip: String, theDeviceName: String) {
        self.id = theID
        self.city = theCity
        self.state = theState
        self.zip = theZip
        self.deviceName = theDeviceName
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "id: \(id), City: \(city), State: \(state), Zip: \(zip), Device Name: \(deviceName)"
        
    }
    
    
}
