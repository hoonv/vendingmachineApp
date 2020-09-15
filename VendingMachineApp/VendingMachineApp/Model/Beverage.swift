//
//  Beverage.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/14.
//  Copyright © 2020 채훈기. All rights reserved.
//

import Foundation

class Beverage {
        
    private let brand: String
    private let capacity: Int
    private(set) var price: Int
    private let name: String
    private let manufacture: Date
    
    init(brand: String, capacity: Int, price: Int, name: String, date: Date) {
        self.brand = brand
        self.capacity = capacity
        self.price = price
        self.name = name
        self.manufacture = date
    }
    
    init(beverage: Beverage) {
        self.brand = beverage.brand
        self.capacity = beverage.capacity
        self.price = beverage.price
        self.name = beverage.name
        self.manufacture = beverage.manufacture
    }
}

extension Beverage: CustomStringConvertible {
    
    var description: String {
        "\(brand), \(capacity)ml, \(price)원, \(name), \(manufacture.yyyymmdd())"
    }
}

extension Beverage: Equatable {
    
    static func == (lhs: Beverage, rhs: Beverage) -> Bool {
        return lhs.brand == rhs.brand && lhs.name == rhs.name
            && lhs.capacity == rhs.capacity && lhs.price == rhs.price
    }
}

extension Beverage: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(brand)
        hasher.combine(name)
        hasher.combine(capacity)
        hasher.combine(price)
    }
}

extension Beverage: Comparable {
    
    static func < (lhs: Beverage, rhs: Beverage) -> Bool {
        return lhs.name == rhs.name ? lhs.brand < rhs.brand : lhs.name < rhs.name
    }
}

extension Date {
    func yyyymmdd() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter.string(from: self)
    }
}
