//
//  EmergencyListCell.swift
//  Emergency
//
//  Created by Sophie Gairo on 12/6/16.
//  Copyright © 2016 Sophie Gairo. All rights reserved.
//

import UIKit

class EmergencyListCell: UITableViewCell {
    
    
    @IBOutlet weak var id_lbl: UILabel!
    
    @IBOutlet weak var idValue_lbl: UILabel!
    
    
    @IBOutlet weak var city_lbl: UILabel!
    
    @IBOutlet weak var cityValue_lbl: UILabel!
    
    @IBOutlet weak var state_lbl: UILabel!
    
    @IBOutlet weak var stateValue_lbl: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
