//
//  Message.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/22.
//  Copyright © 2020 채훈기. All rights reserved.
//

import Foundation

struct Message {
    
    let text: String
    private let sender: Sender
    
    enum Sender {
        case user
        case system
    }
    init(sender: Sender, text: String) {
        self.text = text
        self.sender = sender
    }
    
    func isUser() -> Bool {
        return sender == .user
    }
}
