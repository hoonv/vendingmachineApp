//
//  Milk.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/14.
//  Copyright © 2020 채훈기. All rights reserved.
//

import Foundation

class Milk: Beverage, MilkCheckable {
    
    private static let secondInDay = 86400
    private static let bestDays = 30
    private let expiration: Date
    internal let milkContent: Int

    init(brand: String, capacity: Int, price: Int, name: String, date: Date, milk: Int) {
        expiration = Date(timeIntervalSinceNow: TimeInterval(Milk.secondInDay * Milk.bestDays))
        milkContent = milk
        super.init(brand: brand, capacity: capacity, price: price, name: name, date: date)
    }
    
    init(beverage: Beverage, milk: Int) {
        expiration = Date(timeIntervalSinceNow: TimeInterval(Milk.secondInDay * Milk.bestDays))
        milkContent = milk
        super.init(beverage: beverage)
    }
}

final class ChocoMilk: Milk, SugarCheckable {
    
    internal let sugarContent: Int
    
    init(brand: String, capacity: Int, price: Int, name: String, date: Date, milk: Int, sugar: Int) {
        sugarContent = sugar
        super.init(brand: brand, capacity: capacity, price: price, name: name, date: date, milk: milk)
    }
    
    init(beverage: Beverage, milk: Int, sugar: Int) {
        sugarContent = sugar
        super.init(beverage: beverage, milk: milk)
    }
}

final class StrawberryMilk: Milk, FatCheckable {
    
    internal let fatContent: Int
    
    init(brand: String, capacity: Int, price: Int, name: String, date: Date, milk: Int, fat: Int) {
        fatContent = fat
        super.init(brand: brand, capacity: capacity, price: price, name: name, date: date, milk: milk)
    }
    
    init(beverage: Beverage, milk: Int, fat: Int) {
        fatContent = fat
        super.init(beverage: beverage, milk: milk)
    }
}
