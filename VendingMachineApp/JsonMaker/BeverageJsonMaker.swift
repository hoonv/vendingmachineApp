//
//  BeverageJsonMaker.swift
//  JsonMaker
//
//  Created by 채훈기 on 2020/09/22.
//  Copyright © 2020 채훈기. All rights reserved.
//

import Foundation


func makeBeverageDictForJson(token: String) -> [[String: [String]]] {
        
    var ret: [[String: [String]]] = []
    let nums = ["하나", "둘", "셋", "넷", "다섯", "여섯", "일곱", "여덟", "아홉", "열",
                "2개", "3개", "4개", "5개", "6개", "7개", "8개", "9개", "10개"]

    nums.forEach { num in
        ret.append(["tokens": ["\(token)", "\(num)", "줘"], "labels": ["BEVERAGE", "NUMBER", "GET"]])
        ret.append(["tokens": ["\(token)", "\(num)", "주세요"], "labels": ["BEVERAGE", "NUMBER", "GET"]])
        ret.append(["tokens": ["\(token)", "\(num)", "삽니다"], "labels": ["BEVERAGE", "NUMBER", "GET"]])
        ret.append(["tokens": ["\(token)", "\(num)", "구매"], "labels": ["BEVERAGE", "NUMBER", "GET"]])
        ret.append(["tokens": ["\(token)", "\(num)", "산다"], "labels": ["BEVERAGE", "NUMBER", "GET"]])
        ret.append(["tokens": ["\(token)", "\(num)", "구매합니다"], "labels": ["BEVERAGE", "NUMBER", "GET"]])
    }
    return ret
}
