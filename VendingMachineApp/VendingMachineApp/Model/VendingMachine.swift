//
//  VendingMachine.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/14.
//  Copyright © 2020 채훈기. All rights reserved.
//

import Foundation

struct VendingMachine {
    
    private let manager: ProductManager
    private let balance: Balance
    
    init() {
        balance = Balance()
        manager = ProductManager()
    }
    
    public func currentBalance() -> Int {
        return balance.amount
    }
    
    public func receiveBalance(coin: Int) {
        balance.deposit(amount: coin)
    }
    
    public func receiveBalance(bill: Int) {
        balance.deposit(amount: bill)
    }

    public func returnAllBalance() -> Int {
        return balance.withdrawAll()
    }

    public func receiveOrder(index: Int) -> Beverage? {
        guard let item = manager.receiveOrder(index: index, amount: balance.amount)
            else { return nil }
        let _ = balance.withdraw(amount: item.price)
        return item
    }
    
    public func addProduct(beverage: Beverage) {
        manager.addProduct(beverage: beverage)
    }
    
    public func addProducts(beverages: [Beverage]) {
        manager.addProducts(beverages: beverages)
    }
    
    public func removeProduct(index: Int) {
        manager.removeProduct(index: index)
    }
    
    public func productState() -> [(Beverage, Int)] {
        return manager.productState()
    }
    
    public func findIndex(beverage: Beverage) -> Int? {
        return manager.findIndex(beverage: beverage)
    }
    
    public func isAvailableProductsToSell() -> [Beverage] {
        return manager.isAvailableProductsToSell(amount: balance.amount)
    }
}
