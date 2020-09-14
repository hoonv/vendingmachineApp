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
    let taste: MilkTaste
    
    init(taste: MilkTaste) {
        self.taste = taste
        super.init(brand: "", capacity: 0, price: 0, name: "")
    }
}
