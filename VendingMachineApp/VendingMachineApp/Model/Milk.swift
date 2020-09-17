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
    
    func isHighMilk() -> Bool {
        return milkContent > 10
    }
    
    func isLowMilk() -> Bool {
        return milkContent < 10
    }
}

final class ChocoMilk: Milk, SugarCheckable {
    
    let sugarContent: Int
    
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
    
    func isHighSugar() -> Bool {
        return sugarContent > 10
    }
    
    func isLowSugar() -> Bool {
        return sugarContent < 10
    }
}

final class StrawberryMilk: Milk, FatCheckable {
    
    let fatContent: Int
    
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
    
    func isHighFat() -> Bool {
        return fatContent > 10
    }
    
    func isLowFat() -> Bool {
        return fatContent < 10
    }
}
