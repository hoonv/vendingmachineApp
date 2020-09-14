//
//  Milk.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/14.
//  Copyright © 2020 채훈기. All rights reserved.
//

import Foundation

enum MilkTaste {
    case strawberry
    case choco
    case banana
}

class Milk: Beverage {
    
    private static let secondInDay = 86400
    private static let bestDays = 30
    private let taste: MilkTaste
    private let expiration: Date
    
    init(brand: String, capacity: Int, price: Int, name: String, date: Date, taste: MilkTaste) {
        self.taste = taste
        expiration = Date(timeIntervalSinceNow: TimeInterval(Milk.secondInDay * Milk.bestDays))
        super.init(brand: brand, capacity: capacity, price: price, name: name, date: date)
    }
}
