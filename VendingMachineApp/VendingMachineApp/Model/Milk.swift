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

    private enum CodingKeys: String, CodingKey {
        case milkContent
    }
    
    init(brand: String, capacity: Int, price: Int, name: String, date: Date, milk: Int) {
        milkContent = milk
        super.init(brand: brand, capacity: capacity, price: price, name: name, date: date)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        milkContent = try container.decode(Int.self, forKey: .milkContent)
        try super.init(from: decoder)
    }
}

final class ChocoMilk: Milk, SugarCheckable {
    
    let sugarContent: Int
    var isHighSugar: Bool { sugarContent > 10 }
    var isLowSugar: Bool { sugarContent < 10 }
    
    private enum CodingKeys: String, CodingKey {
        case sugarContent
    }
    
    init(brand: String, capacity: Int, price: Int, name: String, date: Date, milk: Int, sugar: Int) {
        sugarContent = sugar
        super.init(brand: brand, capacity: capacity, price: price, name: name, date: date, milk: milk)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sugarContent = try container.decode(Int.self, forKey: .sugarContent)
        try super.init(from: decoder)
    }
}

final class StrawberryMilk: Milk, FatCheckable {
    
    let fatContent: Int
    var isHighFat: Bool { fatContent > 10 }
    var isLowFat: Bool { fatContent < 10 }
    
    private enum CodingKeys: String, CodingKey {
        case fatContent
    }
    
    init(brand: String, capacity: Int, price: Int, name: String, date: Date, milk: Int, fat: Int) {
        fatContent = fat
        super.init(brand: brand, capacity: capacity, price: price, name: name, date: date, milk: milk)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fatContent = try container.decode(Int.self, forKey: .fatContent)
        try super.init(from: decoder)
    }
}
