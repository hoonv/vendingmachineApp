//
//  Balance.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/16.
//  Copyright © 2020 채훈기. All rights reserved.
//

import Foundation

class Balance: NSObject, NSCoding {
    
    private(set) var amount: Int {
        didSet {
            NotificationCenter.default.post(name: .didChangedCoin, object: amount)
        }
    }
    
    private enum Keys: String {
        case amount
    }

    override init() {
        amount = 0
        super.init()
    }
    
    required init?(coder: NSCoder) {
        amount = coder.decodeInteger(forKey: Keys.amount.rawValue)
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(amount, forKey: Keys.amount.rawValue)
    }

    func deposit(amount: Int) {
        guard self.amount >= 0 else { return }
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
