//
//  VendingMachine.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/14.
//  Copyright © 2020 채훈기. All rights reserved.
//

import Foundation

struct VendingMachine {

    private var coin: Int = 0 {
        didSet {
            NotificationCenter.default.post(name: .didChangedCoin, object: coin)
        }
    }
    private var items: [BeverageLine] = []
    
    init(items: [Beverage] = []) {
        items.forEach {
            addStockBeverage(item: $0)
        }
    }
    
    mutating func addStockBeverages(items: [Beverage]) {
        items.forEach {
            addStockBeverage(item: $0)
        }
    }
    
    mutating func removeCoin(of amount: Int) {
        coin -= amount
    }
    
    func stockToDictionary() -> [Beverage: Int] {
        return items.reduce(into: [Beverage: Int]()) { $0[$1.sample] = $1.count }
    }
    
    func stockToSortedTuple() -> [(Beverage, Int)] {
        return items.map { ($0.sample, $0.count) }
                    .sorted { $0 < $1 }
    }
}

extension Notification.Name {
    static let didChangedCoin = Notification.Name.init("didChanged")
}

protocol MachineManageable {
    
    func removeStockBeverage(item: Beverage)
    mutating func addStockBeverage(item: Beverage)
}

protocol Salable {
    
    func currentCoin() -> Int
    func canBuy() -> [Beverage]
    mutating func buyBeverage(item: Beverage) -> Beverage?
    mutating func pushCoin(of: Int)
}


extension VendingMachine: MachineManageable {
    
    func removeStockBeverage(item: Beverage) {
        let filtered = items.filter { $0.isEqualToSample(another: item) }
        if let first = filtered.first {
            let _ = first.popLast()
        }
    }
    
    mutating func addStockBeverage(item: Beverage) {
        let filtered = items.filter { $0.isEqualToSample(another: item) }
        if let first = filtered.first {
            first.append(new: item)
        } else {
            items.append(BeverageLine(sample: item, items: [item]))
        }
    }
}

extension VendingMachine: Salable {
    
    func currentCoin() -> Int {
        return coin
    }
    
    func canBuy() -> [Beverage] {
        return items.filter{ $0.canBuy(coin: coin) }
                    .map { $0.sample }
    }
    
    mutating func pushCoin(of amount: Int) {
        coin += amount
    }
    
    mutating func buyBeverage(item: Beverage) -> Beverage? {
        let filtered = items.filter {
            $0.isEqualToSample(another: item) && $0.canBuy(coin: coin)
        }
        if let new = filtered.first?.popFirst() {
            removeCoin(of: new.price)
            return new
        }
        return nil
    }
}
