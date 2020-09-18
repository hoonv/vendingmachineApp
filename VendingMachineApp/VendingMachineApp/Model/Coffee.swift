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
}

final class Cantata: Coffee, SugarCheckable {
    
    let sugarContent: Int
    var isHighSugar: Bool { sugarContent > 10 }
    var isLowSugar: Bool { sugarContent < 10 }

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
}

final class Georgia: Coffee, MilkCheckable {

    let milkContent: Int
    var isHighMilk: Bool { milkContent > 10 }
    var isLowMilk: Bool { milkContent < 10 }

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
}
