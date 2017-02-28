//
//  NewEmergency.swift
//  Emergency
//
//  Created by Sophie Gairo on 12/6/16.
//  Copyright © 2016-2017 Sophie Gairo. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class NewEmergency: UIViewController, UITableViewDelegate, UITableViewDataSource, MPCManagerDelegate {
    let loc = GetLocation()
    var city: String!
    var state: String!
    var zip: String!
    var deviceName: String!
    var SelectedUser: String?
    
    @IBOutlet weak var tblPeers: UITableView!
    
    
    @IBOutlet weak var user_lbl: UILabel!
    
    //for toggling the advertising
    var isAdvertising: Bool!
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loc.getAdress { result in
            
            
            self.city = (result["City"] as? String)!
            
            self.zip = (result["ZIP"] as? String)!
            self.state = (result["State"] as? String)!
  
        }
        self.deviceName = UIDevice.current.name
        tblPeers.delegate = self
        tblPeers.dataSource = self
        
        appDelegate.mpcManager.delegate = self
        
        //start browsing as soon as app opens
        appDelegate.mpcManager.browser.startBrowsingForPeers()
        
        //automatically advertise when app opens
        appDelegate.mpcManager.advertiser.startAdvertisingPeer()
        isAdvertising = true
        
        //print(SelectedUser!)
        user_lbl.text = UIDevice.current.name
    }
    
    //reset view
    func foundPeer() {
        tblPeers.reloadData()
        print("In found peer")
    }
    
    //reset view
    func lostPeer() {
        tblPeers.reloadData()
        print("In lost peer")
    }

    
    @IBAction func addEmergency(_ sender: UIButton) {
        
        //TO DO: check if flag is 1, thus user cant post emergency, for now just leave it as is.
        
        //if available through internet, send, otherwise store in local memory and find a way to constantly check for internet
        
        var request = URLRequest(url: URL(string:"http://seniorproject.sophiegairo.com/newEmergency.php")!)
        request.httpMethod = "POST"
        let postString = "city=\(city!)&state=\(state!)&zip=\(zip!)&deviceName=\(deviceName!)"
        
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //rows will match number of peers found
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("number of found peers", appDelegate.mpcManager.foundPeers.count)
        return appDelegate.mpcManager.foundPeers.count
    }
    
    
    //this is where we display the name of each peer found
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCellPeer")! as UITableViewCell
        
        cell.textLabel?.text = appDelegate.mpcManager.foundPeers[indexPath.row].displayName
        
        return cell
    }
    
    //purely cosmetic, determines the height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    //send invitation to selected peer
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPeer = appDelegate.mpcManager.foundPeers[indexPath.row] as MCPeerID
        
        appDelegate.mpcManager.browser.invitePeer(selectedPeer, to: appDelegate.mpcManager.session, withContext: nil, timeout: 20)
        print("In send invitation, send to: ", selectedPeer)
    }
    
    //handles invitation responses
    func invitationWasReceived(fromPeer: String) {
        
        print("In invitation response handler")
        let alert = UIAlertController(title: "", message: "\(fromPeer) wants to chat with you.", preferredStyle: UIAlertControllerStyle.alert)
        
        //if accept then send true and the session
        let acceptAction: UIAlertAction = UIAlertAction(title: "Accept", style: UIAlertActionStyle.default) { (alertAction) -> Void in
            self.appDelegate.mpcManager.invitationHandler(true, self.appDelegate.mpcManager.session)
        }
        
        //if not the send false and nil session
        let declineAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (alertAction) -> Void in
            self.appDelegate.mpcManager.invitationHandler(false, nil)
        }
        
        alert.addAction(acceptAction)
        alert.addAction(declineAction)
        
        OperationQueue.main.addOperation { () -> Void in
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //once a session is started go to the chat view controller
    func connectedWithPeer(peerID: MCPeerID) {
        print("In connect with peer, session sender")
        OperationQueue.main.addOperation { () -> Void in
            self.performSegue(withIdentifier: "idSegueChat", sender: self)
        }//will change for the inviter and the invited
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
