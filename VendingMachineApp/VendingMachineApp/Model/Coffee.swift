//
//  Coffee.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/14.
//  Copyright © 2020 채훈기. All rights reserved.
//

import Foundation

class Coffee: Beverage, CaffeineCheckable {
    
    internal let caffeineContent: Int
    
    init(brand: String, capacity: Int, price: Int, name: String, date: Date, caffeine: Int) {
        caffeineContent = caffeine
        super.init(brand: brand, capacity: capacity, price: price, name: name, date: date)
    }
    
    init(beverage: Beverage, caffeine: Int) {
        caffeineContent = caffeine
        super.init(beverage: beverage)
    }
}

final class Cantata: Coffee, SugarCheckable {
    
    internal let sugarContent: Int
    
    init(brand: String, capacity: Int, price: Int, name: String, date: Date, caffeine: Int, sugar: Int) {
        sugarContent = sugar
        super.init(brand: brand, capacity: capacity, price: price, name: name, date: date, caffeine: caffeine)
    }
    
    init(beverage: Beverage, caffeine: Int, sugar: Int) {
        sugarContent = sugar
        super.init(beverage: beverage, caffeine: caffeine)
    }
}

final class Georgia: Coffee, MilkCheckable {
    
    internal let milkContent: Int
    
    init(brand: String, capacity: Int, price: Int, name: String, date: Date, caffeine: Int, milk: Int) {
        milkContent = milk
        super.init(brand: brand, capacity: capacity, price: price, name: name, date: date, caffeine: caffeine)
    }

    init(beverage: Beverage, caffeine: Int, milk: Int) {
        milkContent = milk
        super.init(beverage: beverage, caffeine: caffeine)
    }
}
