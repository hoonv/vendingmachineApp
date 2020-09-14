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
    let taste: CoffeeTaste
    
    init(taste: CoffeeTaste) {
        self.taste = taste
        super.init(brand: "", capacity: 0, price: 0, name: "")
    }
}
