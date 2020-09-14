//
//  Coffee.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/14.
//  Copyright © 2020 채훈기. All rights reserved.
//

import Foundation

enum CoffeeTaste {
    case top
    case cantata
    case georgia
}

class Coffee: Beverage {
    
    private let taste: CoffeeTaste
    private let caffeine: Int
    
    init(brand: String, capacity: Int, price: Int, name: String, caffeine: Int, date: Date, taste: CoffeeTaste) {
        self.taste = taste
        self.caffeine = caffeine
        super.init(brand: brand, capacity: capacity, price: price, name: name, date: date)
    }
}
