//
//  Milk.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/14.
//  Copyright © 2020 채훈기. All rights reserved.
//

import Foundation

class Milk: Beverage, MilkCheckable {

    let milkContent: Int
    var isHighMilk: Bool { milkContent > 10 }
    var isLowMilk: Bool { milkContent < 10 }

    private enum Keys: String {
        case milkContent
    }
    
    init(brand: String, capacity: Int, price: Int, name: String, date: Date, milk: Int) {
        milkContent = milk
        super.init(brand: brand, capacity: capacity, price: price, name: name, date: date)
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

final class ChocoMilk: Milk, SugarCheckable {
    
    let sugarContent: Int
    var isHighSugar: Bool { sugarContent > 10 }
    var isLowSugar: Bool { sugarContent < 10 }
    
    private enum Keys: String {
        case sugarContent
    }
    
    init(brand: String, capacity: Int, price: Int, name: String, date: Date, milk: Int, sugar: Int) {
        sugarContent = sugar
        super.init(brand: brand, capacity: capacity, price: price, name: name, date: date, milk: milk)
    }
    
    required init?(coder: NSCoder) {
        sugarContent = coder.decodeInteger(forKey: Keys.sugarContent.rawValue)
        super.init(coder: coder)
    }
    
    override func encode(with coder: NSCoder) {
        coder.encode(milkContent, forKey: Keys.sugarContent.rawValue)
        super.encode(with: coder)
    }
}

final class StrawberryMilk: Milk, FatCheckable {
    
    let fatContent: Int
    var isHighFat: Bool { fatContent > 10 }
    var isLowFat: Bool { fatContent < 10 }
    
    private enum Keys: String {
        case fatContent
    }
    
    init(brand: String, capacity: Int, price: Int, name: String, date: Date, milk: Int, fat: Int) {
        fatContent = fat
        super.init(brand: brand, capacity: capacity, price: price, name: name, date: date, milk: milk)
    }

    required init?(coder: NSCoder) {
        fatContent = coder.decodeInteger(forKey: Keys.fatContent.rawValue)
        super.init(coder: coder)
    }
    
    override func encode(with coder: NSCoder) {
        coder.encode(milkContent, forKey: Keys.fatContent.rawValue)
        super.encode(with: coder)
    }
}
