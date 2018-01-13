//
//  DayCellTableViewCell.swift
//  Days
//
//  Created by Daniel Moi on 7/1/18.
//  Copyright © 2018 Daniel Moi. All rights reserved.
//

import UIKit

class DayCellTableViewCell: UITableViewCell {

    // connections
    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var dayDirectionLabel: UILabel!
    
    
    // properties
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
