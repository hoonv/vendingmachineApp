//
//  BeverageFactory.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/15.
//  Copyright © 2020 채훈기. All rights reserved.
//

import Foundation

class BeverageFactory {

    private init() {
        
    }
    
    enum BeverageKind {
        case coke, cider, cantata, georgia, chocoMilk, strawberryMilk
    }
    
    static public func makeBeverage(kind: BeverageKind) -> Beverage {
        switch kind {
        case .coke:
            return Coke(brand: "코카콜라", capacity: 350, price: 2000,
                        name: "캔코카콜라", date: Date(), calorie: 200, sugar: 50)
        case .cantata:
            return Cantata(brand: "롯데", capacity: 300, price: 2500,
                           name: "칸타타커피", date: Date(), caffeine: 20, sugar: 5)
        case .chocoMilk:
            return ChocoMilk(brand: "서울우유", capacity: 250, price: 1500,
                             name: "서울초코우유", date: Date(), milk: 200, sugar: 50)
        case .cider:
            return Cider(brand: "칠성사이다", capacity: 350, price: 2000,
                         name: "칠성사이다", date: Date(), calorie: 200, sugar: 50)
        case .georgia:
            return Georgia(brand: "코카콜라", capacity: 300, price: 2000,
                           name: "조지아커피", date: Date(), caffeine: 30, milk: 50)
        case .strawberryMilk:
            return StrawberryMilk(brand: "서울우유", capacity: 250, price: 1500,
                                  name: "딸기우유", date: Date(), milk: 200, fat: 20)
        }
    }
    
    static public func makeBeverages(kind: BeverageKind, count: Int) -> [Beverage] {
        guard count > 0 else { return [] }
        return (0..<count).map{ _ in makeBeverage(kind: kind)}
    }
}
