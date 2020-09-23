//
//  MsgTableViewCell.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/22.
//  Copyright © 2020 채훈기. All rights reserved.
//

import UIKit

class YellowTableViewCell: UITableViewCell {
    @IBOutlet weak var labelWrapper: UIView!
    @IBOutlet weak var message: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        labelWrapper.layer.cornerRadius = 10
        labelWrapper.layer.cornerRadius = 10
        message.lineBreakMode = .byWordWrapping
        message.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
