//
//  Soda.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/14.
//  Copyright © 2020 채훈기. All rights reserved.
//

import Foundation

enum SodaTaste {
    case coke
    case cider
    case fanta
}

class Soda: Beverage {
    
    private let taste: SodaTaste
    private let calorie: Int
    
    init(brand: String, capacity: Int, price: Int, name: String, calorie: Int, date: Date, taste: SodaTaste) {
        self.taste = taste
        self.calorie = calorie
        super.init(brand: brand, capacity: capacity, price: price, name: name, date: date)
    }
}
