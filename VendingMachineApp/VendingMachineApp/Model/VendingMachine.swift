//
//  VendingMachine.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/14.
//  Copyright © 2020 채훈기. All rights reserved.
//

import Foundation

class VendingMachine: NSObject, NSCoding {
    
    private let manager: ProductManager
    private let balance: Balance
    private let history: SellHistory
    
    private enum Keys: String {
        case manager
        case balance
        case history
    }
    
    override init() {
        balance = Balance()
        manager = ProductManager()
        history = SellHistory()
        super.init()
        setupSample()
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(manager, forKey: Keys.manager.rawValue)
        coder.encode(balance, forKey: Keys.balance.rawValue)
        coder.encode(history, forKey: Keys.history.rawValue)
    }
    
    required init?(coder: NSCoder) {
        manager = coder.decodeObject(forKey: Keys.manager.rawValue) as? ProductManager ?? ProductManager()
        balance = coder.decodeObject(forKey: Keys.balance.rawValue) as? Balance ?? Balance()
        history = coder.decodeObject(forKey: Keys.history.rawValue) as? SellHistory ?? SellHistory()
    }

    
    private func setupSample() {
        addProduct(beverage: BeverageFactory.makeBeverage(kind: .cantata))
        addProduct(beverage: BeverageFactory.makeBeverage(kind: .chocoMilk))
        addProduct(beverage: BeverageFactory.makeBeverage(kind: .cider))
        addProduct(beverage: BeverageFactory.makeBeverage(kind: .coke))
        addProduct(beverage: BeverageFactory.makeBeverage(kind: .georgia))
        addProduct(beverage: BeverageFactory.makeBeverage(kind: .strawberryMilk))
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
        history.append(beverage: item)
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
    
    public func isAvailableProductsToSell() -> [Bool] {
        return manager.isAvailableProductsToSell(amount: balance.amount)
    }
    
    public func removeHistory() {
        history.clear()
    }
}


