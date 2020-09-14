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
    private let price: Int
    private let name: String
    private let manufacture: Date
    
    init(brand: String, capacity: Int, price: Int, name: String, date: Date) {
        self.brand = brand
        self.capacity = capacity
        self.price = price
        self.name = name
        self.manufacture = date
    }
}

extension Beverage: CustomStringConvertible {
    var description: String {
        "\(brand), \(capacity)ml, \(price)원, \(name), \(manufacture)"
    }
}

