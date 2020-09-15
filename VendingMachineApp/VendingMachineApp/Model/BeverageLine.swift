//
//  BeverageLine.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/15.
//  Copyright © 2020 채훈기. All rights reserved.
//

import Foundation

class BeverageLine {
    
    private(set) var sample: Beverage
    private var items: [Beverage] {
        didSet {
            let object: [String : Any] = ["sample": sample, "count": count]
            NotificationCenter.default.post(name: .didChangeBeverage, object: object)
        }
    }
    var count: Int { return items.count }
    
    init(sample: Beverage, items: [Beverage] = []) {
        self.sample = sample
        self.items = items
    }
    
    func isEmpty() -> Bool {
        return items.isEmpty
    }
    
    func isEqualToSample(another: Beverage) -> Bool {
        return sample == another
    }
    
    func canBuy(coin: Int) -> Bool{
        return coin >= sample.price && !isEmpty()
    }
    
    func popFirst() -> Beverage? {
        if isEmpty() { return nil }
        return items.removeFirst()
    }
    
    func popLast() -> Beverage? {
        return items.popLast()
    }
    
    func append(new: Beverage) {
        guard new == sample else { return }
        items.append(new)
    }
}

extension Notification.Name {
    
    static let didChangeBeverage = Notification.Name.init("changedBeverage")
}

