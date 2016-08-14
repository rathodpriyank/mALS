//
//  MyTableViewCellNotifications.swift
//  mALS test
//
//  Created by Joshua Herrera on 7/22/15.
//  Copyright (c) 2015 Joshua Herrera. All rights reserved.
//

import UIKit

class MyTableViewCellNotifications: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var roomNumber: UILabel!
    @IBOutlet weak var payload: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
