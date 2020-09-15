//
//  Protocols.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/14.
//  Copyright © 2020 채훈기. All rights reserved.
//

import Foundation

protocol SugarCheckable {
    
    var sugarContent: Int { get }
    
    func isHighSugar() -> Bool
    func isLowSugar() -> Bool
}

protocol CalorieCheckable {
    
    var calorieContent: Int { get }
    
    func isHighCalorie() -> Bool
    func isLowCalorie() -> Bool
}

protocol FatCheckable {
    
    var fatContent: Int { get }
    
    func isHighFat() -> Bool
    func isLowFat() -> Bool
}

protocol CaffeineCheckable {
    
    var caffeineContent: Int { get }
    
    func isHighCaffeine() -> Bool
    func isLowCaffeine() -> Bool
}

protocol MilkCheckable {
    
    var milkContent: Int { get }
    
    func isHighMilk() -> Bool
    func isLowMilk() -> Bool
}
