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
    var isHighCalorie: Bool { calorieContent > 10 }
    var isLowCalorie: Bool { calorieContent < 10 }

    private enum Keys: String {
        case calorieContent
    }
    
    init(brand: String, capacity: Int, price: Int, name: String, date: Date, calorie: Int) {
        calorieContent = calorie
        super.init(brand: brand, capacity: capacity, price: price, name: name, date: date)
    }

    required init?(coder: NSCoder) {
        calorieContent = coder.decodeInteger(forKey: Keys.calorieContent.rawValue)
        super.init(coder: coder)
    }
    
    override func encode(with coder: NSCoder) {
        coder.encode(calorieContent, forKey: Keys.calorieContent.rawValue)
        super.encode(with: coder)
    }
}

final class Coke: Soda, SugarCheckable {
    
    let sugarContent: Int
    var isHighSugar: Bool { sugarContent > 10 }
    var isLowSugar: Bool { sugarContent < 10 }

    private enum Keys: String {
          case sugarContent
    }
    
    init(brand: String, capacity: Int, price: Int, name: String, date: Date, calorie: Int, sugar: Int) {
        sugarContent = sugar
        super.init(brand: brand, capacity: capacity, price: price, name: name, date: date, calorie: calorie)
    }

    required init?(coder: NSCoder) {
        sugarContent = coder.decodeInteger(forKey: Keys.sugarContent.rawValue)
        super.init(coder: coder)
    }
    
    override func encode(with coder: NSCoder) {
        coder.encode(sugarContent, forKey: Keys.sugarContent.rawValue)
        super.encode(with: coder)
    }
}


final class Cider: Soda, SugarCheckable {
    
    let sugarContent: Int
    var isHighSugar: Bool { sugarContent > 10 }
    var isLowSugar: Bool { sugarContent < 10 }

    private enum Keys: String {
          case sugarContent
    }
    
    init(brand: String, capacity: Int, price: Int, name: String, date: Date, calorie: Int, sugar: Int) {
        sugarContent = sugar
        super.init(brand: brand, capacity: capacity, price: price, name: name, date: date, calorie: calorie)
    }

    required init?(coder: NSCoder) {
        sugarContent = coder.decodeInteger(forKey: Keys.sugarContent.rawValue)
        super.init(coder: coder)
    }
    
    override func encode(with coder: NSCoder) {
        coder.encode(sugarContent, forKey: Keys.sugarContent.rawValue)
        super.encode(with: coder)
    }
}
