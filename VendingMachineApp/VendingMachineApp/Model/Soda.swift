//
//  Soda.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/14.
//  Copyright © 2020 채훈기. All rights reserved.
//

import Foundation

class Soda: Beverage, CalorieCheckable {
    
    internal let calorieContent: Int
        
    init(brand: String, capacity: Int, price: Int, name: String, date: Date, calorie: Int) {
        calorieContent = calorie
        super.init(brand: brand, capacity: capacity, price: price, name: name, date: date)
    }
    
    init(beverage: Beverage, calorie: Int) {
        calorieContent = calorie
        super.init(beverage: beverage)
    }
}

final class Coke: Soda, SugarCheckable {
    
    internal let sugarContent: Int
    
    init(brand: String, capacity: Int, price: Int, name: String, date: Date, calorie: Int, sugar: Int) {
        sugarContent = sugar
        super.init(brand: brand, capacity: capacity, price: price, name: name, date: date, calorie: calorie)
    }
    
    init(beverage: Beverage, calorie: Int, sugar: Int) {
        sugarContent = sugar
        super.init(beverage: beverage, calorie: calorie)
    }
}


final class Cider: Soda, SugarCheckable {
    
    internal let sugarContent: Int

    init(brand: String, capacity: Int, price: Int, name: String, date: Date, calorie: Int, sugar: Int) {
        sugarContent = sugar
        super.init(brand: brand, capacity: capacity, price: price, name: name, date: date, calorie: calorie)
    }
    
    init(beverage: Beverage, calorie: Int, sugar: Int) {
        sugarContent = sugar
        super.init(beverage: beverage, calorie: calorie)
    }
}
