//
//  MyTableViewCellForManagerTableViewCell.swift
//  mALS test
//
//  Created by Joshua Herrera on 7/21/15.
//  Copyright (c) 2015 Joshua Herrera. All rights reserved.
//

import UIKit

class MyTableViewCellForManager: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var alertsButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
