//
//  Coffee.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/14.
//  Copyright © 2020 채훈기. All rights reserved.
//

import Foundation

class Coffee: Beverage, CaffeineCheckable {
    
    let caffeineContent: Int
    
    init(brand: String, capacity: Int, price: Int, name: String, date: Date, caffeine: Int) {
        caffeineContent = caffeine
        super.init(brand: brand, capacity: capacity, price: price, name: name, date: date)
    }
    
    func isHighCaffeine() -> Bool {
        return caffeineContent > 10
    }
    
    func isLowCaffeine() -> Bool {
        return caffeineContent < 10
    }
}

final class Cantata: Coffee, SugarCheckable {
    
    let sugarContent: Int
    
    init(brand: String, capacity: Int, price: Int, name: String, date: Date, caffeine: Int, sugar: Int) {
        sugarContent = sugar
        super.init(brand: brand, capacity: capacity, price: price, name: name, date: date, caffeine: caffeine)
    }
    
    func isHighSugar() -> Bool {
        return sugarContent > 10
    }
    
    func isLowSugar() -> Bool {
        return sugarContent < 10
    }
}

final class Georgia: Coffee, MilkCheckable {

    let milkContent: Int
    
    init(brand: String, capacity: Int, price: Int, name: String, date: Date, caffeine: Int, milk: Int) {
        milkContent = milk
        super.init(brand: brand, capacity: capacity, price: price, name: name, date: date, caffeine: caffeine)
    }
    
    func isHighMilk() -> Bool {
        return milkContent > 10
    }
    
    func isLowMilk() -> Bool {
        return milkContent < 10
    }
}
