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
    let taste: SodaTaste
    
    init(taste: SodaTaste) {
        self.taste = taste
        super.init(brand: "", capacity: 0, price: 0, name: "")
    }
}
