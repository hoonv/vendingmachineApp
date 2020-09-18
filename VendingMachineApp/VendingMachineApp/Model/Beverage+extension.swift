//
//  Beverage+extension.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/18.
//  Copyright © 2020 채훈기. All rights reserved.
//

import Foundation
import UIKit

extension Beverage {
    func convertToUIImage() -> UIImage? {
        switch self.name {
        case "캔코카콜라":
            return UIImage(named: "coke.png")
        case "칠성사이다":
            return UIImage(named: "cider.png")
        case "딸기우유":
            return UIImage(named: "strawberry.png")
        case "서울초코우유":
            return UIImage(named: "choco.png")
        case "칸타타커피":
            return UIImage(named: "cantata.png")
        case "조지아커피":
            return UIImage(named: "georgia.png")
        default:
            return UIImage(named: "")
        }
    }
}
