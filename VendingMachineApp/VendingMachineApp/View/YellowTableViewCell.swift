//
//  MsgTableViewCell.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/22.
//  Copyright © 2020 채훈기. All rights reserved.
//

import UIKit

class YellowTableViewCell: UITableViewCell {

    @IBOutlet weak var message: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
