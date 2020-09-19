//
//  SellHistory.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/17.
//  Copyright © 2020 채훈기. All rights reserved.
//

import Foundation

class SellHistory: NSObject, NSCoding {
    
    private(set) var items: [Beverage] {
        didSet {
            NotificationCenter.default.post(name: .historyDidChanged, object: items)
        }
    }
    
    private enum Keys: String {
        case items
    }
    
    override init() {
        items = []
    }
    
    required init?(coder: NSCoder) {
        items = coder.decodeObject(forKey: Keys.items.rawValue) as? [Beverage] ?? []

    }
    
    func encode(with coder: NSCoder) {
        coder.encode(items, forKey: Keys.items.rawValue)
    }
    
    func append(beverage: Beverage) {
        items.append(beverage)
        if items.count % 10 == 0 {
            NotificationCenter.default.post(name: .mutipleOfTen, object: nil)
        }
    }
    
    func clear() {
        items.removeAll()
    }
}

extension Notification.Name {
    
    static let historyDidChanged = Notification.Name.init("historyDidChanged")
    static let mutipleOfTen = Notification.Name.init("mutipleOfTen")
}
