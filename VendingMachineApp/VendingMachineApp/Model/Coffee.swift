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
    
    private enum CodingKeys: String, CodingKey {
        case caffeineContent
    }
    
    init(brand: String, capacity: Int, price: Int, name: String, date: Date, caffeine: Int) {
        caffeineContent = caffeine
        super.init(brand: brand, capacity: capacity, price: price, name: name, date: date)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        caffeineContent = try container.decode(Int.self, forKey: .caffeineContent)
        try super.init(from: decoder)
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
    
    private enum CodingKeys: String, CodingKey {
        case sugarContent
    }
    
    init(brand: String, capacity: Int, price: Int, name: String, date: Date, caffeine: Int, sugar: Int) {
        sugarContent = sugar
        super.init(brand: brand, capacity: capacity, price: price, name: name, date: date, caffeine: caffeine)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sugarContent = try container.decode(Int.self, forKey: .sugarContent)
        try super.init(from: decoder)
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
    
    private enum CodingKeys: String, CodingKey {
         case milkContent
     }
    
    init(brand: String, capacity: Int, price: Int, name: String, date: Date, caffeine: Int, milk: Int) {
        milkContent = milk
        super.init(brand: brand, capacity: capacity, price: price, name: name, date: date, caffeine: caffeine)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        milkContent = try container.decode(Int.self, forKey: .milkContent)
        try super.init(from: decoder)
    }
    
    func isHighMilk() -> Bool {
        return milkContent > 10
    }
    
    func isLowMilk() -> Bool {
        return milkContent < 10
    }
}
