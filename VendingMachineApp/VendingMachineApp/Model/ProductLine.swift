//
//  BeverageLine.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/15.
//  Copyright © 2020 채훈기. All rights reserved.
//

import Foundation

class ProductLine: NSObject, NSCoding {
    
    private(set) var sample: Beverage
    private var items: [Beverage] {
        didSet {
            let object: [String : Any] = ["sample": sample, "count": count]
            NotificationCenter.default.post(name: .didChangeBeverage, object: object)
        }
    }
    var count: Int { return items.count }
    var isEmpty: Bool { return items.isEmpty }
    
    private enum Keys: String {
        case sample
        case items
    }
    
    init(sample: Beverage, items: [Beverage] = []) {
        self.sample = sample
        self.items = items
    }

    required init?(coder: NSCoder) {
        sample = coder.decodeObject(forKey: Keys.sample.rawValue) as?
            Beverage ?? BeverageFactory.makeBeverage(kind: .cantata)
        items = coder.decodeObject(forKey: Keys.items.rawValue) as? [Beverage] ?? []
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(sample, forKey: Keys.sample.rawValue)
        coder.encode(items, forKey: Keys.items.rawValue)
    }
    
    func isAvailableToAppend(item: Beverage) -> Bool {
        return sample == item
    }
    
    func isAvailableToSell(amount: Int) -> Bool{
        return amount >= sample.price && !isEmpty
    }
    
    func popFirst() -> Beverage? {
        if isEmpty { return nil }
        return items.removeFirst()
    }
    
    func popLast() -> Beverage? {
        return items.popLast()
    }
    
    func append(item: Beverage) {
        guard item == sample else { return }
        items.append(item)
    }
}

extension Notification.Name {
    
    static let didChangeBeverage = Notification.Name.init("changedBeverage")
}

