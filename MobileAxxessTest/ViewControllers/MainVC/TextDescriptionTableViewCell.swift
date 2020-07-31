//
//  TextDescriptionTableViewCell.swift
//  MobileAxxessTest
//
//  Created by devang bhavsar on 30/07/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//

import UIKit

class TextDescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
