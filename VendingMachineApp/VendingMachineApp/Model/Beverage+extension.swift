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
        switch self {
        case _ as Coke:
            return UIImage(named: "coke.png")
        case _ as Cider:
            return UIImage(named: "cider.png")
        case _ as StrawberryMilk:
            return UIImage(named: "strawberry.png")
        case _ as ChocoMilk:
            return UIImage(named: "choco.png")
        case _ as Cantata:
            return UIImage(named: "cantata.png")
        case _ as Georgia:
            return UIImage(named: "georgia.png")
        default:
            return UIImage(named: "")
        }
    }
}
