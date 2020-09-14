//
//  VendingMachine.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/14.
//  Copyright © 2020 채훈기. All rights reserved.
//

import Foundation

struct VendingMachine {

    private var coin: Int
}


protocol MachineManageable {
    
    func addStockBeverage()
    func removeStockBeverage()
    func expiredBeverage()
}

protocol Salable {
    
    func checkBalance()
    func buyBeverage()
    func availableBeverage()
}



extension VendingMachine: MachineManageable {
    
    func addStockBeverage() {
        
    }
    
    func removeStockBeverage() {
        
    }
    
    func expiredBeverage() {
        
    }
}


extension VendingMachine: Salable {
    
    func checkBalance() {
        
    }
    
    func buyBeverage() {
        
    }
    
    func availableBeverage() {
        
    }
}
