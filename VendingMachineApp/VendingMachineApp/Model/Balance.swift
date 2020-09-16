//
//  Balance.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/16.
//  Copyright © 2020 채훈기. All rights reserved.
//

import Foundation

class Balance {
    
    private(set) var amount: Int {
        didSet {
            NotificationCenter.default.post(name: .didChangedCoin, object: amount)
        }
    }

    init() {
        amount = 0
    }
    
    func deposit(amount: Int) {
        self.amount += amount
    }
    
    func withdraw(amount: Int) -> Int {
        guard self.amount >= amount else { return 0 }
        self.amount -= amount
        return amount
    }
    
    func withdrawAll() -> Int {
        return withdraw(amount: amount)
    }
}

extension Notification.Name {
    static let didChangedCoin = Notification.Name.init("didChanged")
}
