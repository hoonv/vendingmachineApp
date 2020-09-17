//
//  Soda.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/14.
//  Copyright © 2020 채훈기. All rights reserved.
//

import Foundation

class Soda: Beverage, CalorieCheckable {
    
    let calorieContent: Int
        
    private enum CodingKeys: String, CodingKey {
        case calorieContent
    }
    
    init(brand: String, capacity: Int, price: Int, name: String, date: Date, calorie: Int) {
        calorieContent = calorie
        super.init(brand: brand, capacity: capacity, price: price, name: name, date: date)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        calorieContent = try container.decode(Int.self, forKey: .calorieContent)
        try super.init(from: decoder)
    }
    
    func isHighCalorie() -> Bool {
        return calorieContent > 10
    }
    
    func isLowCalorie() -> Bool {
        return calorieContent < 10
    }
}

final class Coke: Soda, SugarCheckable {
    
    let sugarContent: Int
    
    private enum CodingKeys: String, CodingKey {
        case sugarContent
    }
    
    init(brand: String, capacity: Int, price: Int, name: String, date: Date, calorie: Int, sugar: Int) {
        sugarContent = sugar
        super.init(brand: brand, capacity: capacity, price: price, name: name, date: date, calorie: calorie)
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


final class Cider: Soda, SugarCheckable {
    
    let sugarContent: Int

    private enum CodingKeys: String, CodingKey {
        case sugarContent
    }
    
    init(brand: String, capacity: Int, price: Int, name: String, date: Date, calorie: Int, sugar: Int) {
        sugarContent = sugar
        super.init(brand: brand, capacity: capacity, price: price, name: name, date: date, calorie: calorie)
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
