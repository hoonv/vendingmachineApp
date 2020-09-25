//
//  main.swift
//  JsonMaker
//
//  Created by 채훈기 on 2020/09/22.
//  Copyright © 2020 채훈기. All rights reserved.
//

import Foundation

var beverages: [[String: [String]]] = []
let beverageTokens = ["콜라", "코카콜라", "사이다", "딸기우유", "바나나우유",
                      "칠성사이다", "칸타타", "조지아", "칸타타커피", "조지아커피"]

beverageTokens.forEach { beverages.append(contentsOf: makeBeverageDictForJson(token: $0)) }

do {
    let fileURL = try FileManager.default
        .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        .appendingPathComponent("trading.json")
    try JSONSerialization.data(withJSONObject: beverages)
        .write(to: fileURL)
} catch {
    print(error)
}
