//
//  SellHistory.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/17.
//  Copyright © 2020 채훈기. All rights reserved.
//

import Foundation

class SellHistory: Codable {
    
    var items: [Beverage] {
        didSet {
            NotificationCenter.default.post(name: .historyDidChanged, object: items)
        }
    }
    
    init() {
        items = []
    }
    
    func append(beverage: Beverage) {
        items.append(beverage)
    }
    
    func clear() {
        items.removeAll()
    }
}

extension Notification.Name {
    
    static let historyDidChanged = Notification.Name.init("historyDidChanged")
}
