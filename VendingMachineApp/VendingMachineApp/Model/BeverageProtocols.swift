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
    var isHighSugar: Bool { get }
    var isLowSugar: Bool { get }
}

protocol CalorieCheckable {
    
    var calorieContent: Int { get }
    var isHighCalorie: Bool { get }
    var isLowCalorie: Bool { get }
}

protocol FatCheckable {
    
    var fatContent: Int { get }
    var isHighFat: Bool { get }
    var isLowFat: Bool { get }
}

protocol CaffeineCheckable {
    
    var caffeineContent: Int { get }
    var isHighCaffeine: Bool { get }
    var isLowCaffeine: Bool { get }
}

protocol MilkCheckable {
    
    var milkContent: Int { get }
    var isHighMilk: Bool { get }
    var isLowMilk: Bool { get }
}
