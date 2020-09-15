//
//  BeverageFactory.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/15.
//  Copyright © 2020 채훈기. All rights reserved.
//

import Foundation

class BeverageFactory {
    
    public func makeCoke() -> Beverage {
        return Coke(brand: "코카콜라", capacity: 350, price: 2000,
                    name: "캔코카콜라", date: Date(), calorie: 200, sugar: 50)
    }
    
    public func makeFanta() -> Beverage {
        return Cider(brand: "칠성사이다", capacity: 350, price: 2000,
                     name: "칠성사이다", date: Date(), calorie: 200, sugar: 50)
    }
    
    public func makeCantata() -> Beverage {
        return Cantata(brand: "롯데", capacity: 300, price: 2500,
                       name: "칸타타", date: Date(), caffeine: 20, sugar: 5)
    }
    
    public func makeGeorgia() -> Beverage {
        return Georgia(brand: "코카콜라", capacity: 300, price: 2000,
                       name: "조지아커피", date: Date(), caffeine: 30, milk: 50)
    }
    
    public func makeChocoMilk() -> Beverage {
        return ChocoMilk(brand: "서울우유", capacity: 250, price: 1500,
                         name: "서울초코우유", date: Date(), milk: 200, sugar: 50)
    }
    
    public func makeStrawberryMilk() -> Beverage {
        return StrawberryMilk(brand: "충남우유", capacity: 250, price: 1500,
                              name: "논산딸기우유", date: Date(), milk: 200, fat: 20)
    }
}