//
//  ProductManager.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/16.
//  Copyright © 2020 채훈기. All rights reserved.
//

import Foundation

class ProductManager: Codable {
    
    private var lines: [ProductLine]
    
    init() {
        lines = []
    }
    
    func setupSample() {
        lines.append(ProductLine(sample: BeverageFactory.makeBeverage(kind: .cantata)))
        lines.append(ProductLine(sample: BeverageFactory.makeBeverage(kind: .chocoMilk)))
        lines.append(ProductLine(sample: BeverageFactory.makeBeverage(kind: .cider)))
        lines.append(ProductLine(sample: BeverageFactory.makeBeverage(kind: .coke)))
        lines.append(ProductLine(sample: BeverageFactory.makeBeverage(kind: .georgia)))
        lines.append(ProductLine(sample: BeverageFactory.makeBeverage(kind: .strawberryMilk)))
    }
    
    func addProduct(beverage: Beverage) {
        let filtered = lines.filter { $0.isAvailableToAppend(item: beverage) }
        if let first = filtered.first {
            first.append(item: beverage)
        } else {
            lines.append(ProductLine(sample: beverage, items: [beverage]))
        }
    }
    
    func addProducts(beverages: [Beverage]) {
        beverages.forEach { addProduct(beverage: $0) }
    }
    
    func removeProduct(index: Int) {
        guard index < lines.count else { return }
        let _ = lines[index].popLast()
    }
    
    func receiveOrder(index: Int, amount: Int) -> Beverage? {
        guard index < lines.count else { return nil }
        guard lines[index].isAvailableToSell(amount: amount) else { return nil}
        return lines[index].popFirst()
    }
    
    func isAvailableProductsToSell(amount: Int) -> [Beverage] {
        return lines.filter { $0.isAvailableToSell(amount: amount) }.map { $0.sample }
    }
    
    func productState() -> [(Beverage, Int)] {
        return lines.map { ($0.sample, $0.count) }
    }
    
    func findIndex(beverage: Beverage) -> Int? {
        return lines.firstIndex { $0.isAvailableToAppend(item: beverage) }
    }
}

