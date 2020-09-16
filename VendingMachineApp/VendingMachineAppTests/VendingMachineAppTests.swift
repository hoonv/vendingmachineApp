//
//  VendingMachineAppTests.swift
//  VendingMachineAppTests
//
//  Created by 채훈기 on 2020/09/14.
//  Copyright © 2020 채훈기. All rights reserved.
//

import XCTest
@testable import VendingMachineApp

class VendingMachineAppTests: XCTestCase {

    var vm = VendingMachine()
    var factory = BeverageFactory()
    
    override func setUpWithError() throws {
        vm.addStockBeverages(items: factory.makeBeverages(kind: .cantata, count: 10)) // 2500원
        vm.addStockBeverages(items: factory.makeBeverages(kind: .coke, count: 10)) // 2000원
        vm.addStockBeverages(items: factory.makeBeverages(kind: .chocoMilk, count: 10)) // 1500원
    }

    override func tearDownWithError() throws {
        vm = VendingMachine()
    }

    func test_1500원으로_살수있는_초코우유() throws {
        vm.pushCoin(of: 1500)
        XCTAssertEqual(vm.canBuy().count, 1)
    }

    func test_2000원으로_살수있는_초코우유와콜라() throws {
        vm.pushCoin(of: 2000)
        XCTAssertEqual(vm.canBuy().count, 2)
    }

    func test_2500원으로_살수있는_초코우유와콜라칸타타() throws {
        vm.pushCoin(of: 2500)
        XCTAssertEqual(vm.canBuy().count, 3)
    }
    
    func test_1500원투입후_초코우유사먹고_0원확인() throws {
        vm.pushCoin(of: 1500)
        let _ = vm.buyBeverage(item: factory.makeBeverage(kind: .chocoMilk))
        XCTAssertEqual(vm.currentCoin(), 0)
    }

    func test_1500원투입후_콜라사먹으려하지만_실패해서_돈그대로() throws {
        vm.pushCoin(of: 1500)
        let _ = vm.buyBeverage(item: factory.makeBeverage(kind: .coke))
        XCTAssertEqual(vm.currentCoin(), 1500)
    }
    
    func test_5000원투입후_칸타타콜라사먹고_남은돈500원() throws {
        vm.pushCoin(of: 5000)
        let _ = vm.buyBeverage(item: factory.makeBeverage(kind: .cantata))
        let _ = vm.buyBeverage(item: factory.makeBeverage(kind: .coke))
        XCTAssertEqual(vm.currentCoin(), 500)
    }
    
    func test_5000원투입후_칸타타콜라사먹고_남은품목28개() throws {
        vm.pushCoin(of: 5000)
        let _ = vm.buyBeverage(item: factory.makeBeverage(kind: .coke))
        let _ = vm.buyBeverage(item: factory.makeBeverage(kind: .cantata))
        let count = vm.stockToDictionary().reduce(0) {
            $0 + $1.value
        }
        XCTAssertEqual(count, 28)
    }
}
