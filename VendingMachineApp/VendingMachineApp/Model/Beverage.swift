//
//  Beverage.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/14.
//  Copyright © 2020 채훈기. All rights reserved.
//

import Foundation

class Beverage: NSObject, NSCoding {
    
    private let brand: String
    private let capacity: Int
    private(set) var price: Int
    private(set) var name: String
    private let manufacture: Date
    
    enum Keys: String {
        case brand
        case capacity
        case price
        case name
        case manufacture
    }
    
    init(brand: String, capacity: Int, price: Int, name: String, date: Date) {
        self.brand = brand
        self.capacity = capacity
        self.price = price
        self.name = name
        self.manufacture = date
    }
    
    required init?(coder: NSCoder) {
        brand = coder.decodeObject(forKey: Keys.brand.rawValue) as? String ?? ""
        capacity = coder.decodeInteger(forKey: Keys.capacity.rawValue)
        price = coder.decodeInteger(forKey: Keys.price.rawValue)
        name = coder.decodeObject(forKey: Keys.name.rawValue) as? String ?? ""
        manufacture = coder.decodeObject(forKey: Keys.manufacture.rawValue) as? Date ?? Date()
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(brand, forKey: Keys.brand.rawValue)
        coder.encode(capacity, forKey: Keys.capacity.rawValue)
        coder.encode(price, forKey: Keys.price.rawValue)
        coder.encode(name, forKey: Keys.name.rawValue)
        coder.encode(manufacture, forKey: Keys.manufacture.rawValue)

    }
}

extension Beverage {

    override var description: String {
        "\(brand), \(capacity)ml, \(price)원, \(name), \(manufacture.toString(format: "yyyyMMdd"))"
    }
}

extension Beverage {
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let obj = object as? Beverage else { return false }
        return brand == obj.brand && capacity == obj.capacity
            && price == obj.price && name == obj.name
    }
    
    override var hash: Int {
        var hasher = Hasher()
        hasher.combine(brand)
        hasher.combine(capacity)
        hasher.combine(price)
        hasher.combine(name)
        return hasher.finalize()
    }
}

extension Date {
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
