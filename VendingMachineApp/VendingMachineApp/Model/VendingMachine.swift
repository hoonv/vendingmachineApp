//
//  VendingMachine.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/14.
//  Copyright © 2020 채훈기. All rights reserved.
//

import Foundation

protocol MachineManageable {
    
    func addStockBeverage(new: Beverage)
    func removeStockBeverage(of: Beverage)
    func expiredBeverage()
}

protocol Salable {
    
    func checkCoin() -> Int
    func buyBeverage() -> Beverage
    func availableBeverage() -> [Beverage]
    mutating func pushCoin(of coin: Int)
}

struct VendingMachine {

    private var coin: Int
    private var items: [Beverage: Int]
    
    init() {
        coin = 0
        items = [:]
    }
}


extension VendingMachine: MachineManageable {
    
    func addStockBeverage(new: Beverage) {
        
    }
    
    func removeStockBeverage(of bever: Beverage) {
        
    }
    
    func expiredBeverage() {
        
    }
}



extension VendingMachine: Salable {
    
    mutating func pushCoin(of coin: Int) {
        self.coin += coin
    }
    
    func checkCoin() -> Int {
        return coin
    }
    
    func buyBeverage() -> Beverage {
        
    }
    
    func availableBeverage() -> [Beverage] {
    }
}
