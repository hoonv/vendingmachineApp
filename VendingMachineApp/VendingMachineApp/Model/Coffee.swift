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
    var isHighCaffeine: Bool { caffeineContent > 10 }
    var isLowCaffeine: Bool { caffeineContent < 10 }

    
    private enum Keys: String {
          case caffeineContent
    }
    
    init(brand: String, capacity: Int, price: Int, name: String, date: Date, caffeine: Int) {
        caffeineContent = caffeine
        super.init(brand: brand, capacity: capacity, price: price, name: name, date: date)
    }

    required init?(coder: NSCoder) {
        caffeineContent = coder.decodeInteger(forKey: Keys.caffeineContent.rawValue)
        super.init(coder: coder)
    }
    
    override func encode(with coder: NSCoder) {
        coder.encode(caffeineContent, forKey: Keys.caffeineContent.rawValue)
        super.encode(with: coder)
    }
}

final class Cantata: Coffee, SugarCheckable {
    
    let sugarContent: Int
    var isHighSugar: Bool { sugarContent > 10 }
    var isLowSugar: Bool { sugarContent < 10 }

    private enum Keys: String {
          case sugarContent
    }
    
    init(brand: String, capacity: Int, price: Int, name: String, date: Date, caffeine: Int, sugar: Int) {
        sugarContent = sugar
        super.init(brand: brand, capacity: capacity, price: price, name: name, date: date, caffeine: caffeine)
    }

    required init?(coder: NSCoder) {
        sugarContent = coder.decodeInteger(forKey: Keys.sugarContent.rawValue)
        super.init(coder: coder)
    }
    
    override func encode(with coder: NSCoder) {
        coder.encode(sugarContent, forKey: Keys.sugarContent.rawValue)
        super.encode(with: coder)
    }
}

final class Georgia: Coffee, MilkCheckable {

    let milkContent: Int
    var isHighMilk: Bool { milkContent > 10 }
    var isLowMilk: Bool { milkContent < 10 }

    private enum Keys: String {
          case milkContent
    }
    
    init(brand: String, capacity: Int, price: Int, name: String, date: Date, caffeine: Int, milk: Int) {
        milkContent = milk
        super.init(brand: brand, capacity: capacity, price: price, name: name, date: date, caffeine: caffeine)
    }

    required init?(coder: NSCoder) {
        milkContent = coder.decodeInteger(forKey: Keys.milkContent.rawValue)
        super.init(coder: coder)
    }
    
    override func encode(with coder: NSCoder) {
        coder.encode(milkContent, forKey: Keys.milkContent.rawValue)
        super.encode(with: coder)
    }
}
