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
        vm.addProducts(beverages: factory.makeBeverages(kind: .cantata, count: 10))
        vm.addProducts(beverages: factory.makeBeverages(kind: .coke, count: 10))
        vm.addProducts(beverages: factory.makeBeverages(kind: .chocoMilk, count: 10))
    }

    override func tearDownWithError() throws {
        vm = VendingMachine()
    }

    func test_1500원으로_살수있는_초코우유() throws {
        vm.receiveBalance(coin: 1500)
        XCTAssertEqual(vm.isAvailableProductsToSell().count, 1)
    }

    func test_2000원으로_살수있는_초코우유와콜라() throws {
        vm.receiveBalance(coin: 2000)
        XCTAssertEqual(vm.isAvailableProductsToSell().count, 2)
    }

    func test_2500원으로_살수있는_초코우유와콜라칸타타() throws {
        vm.receiveBalance(coin: 2500)
        XCTAssertEqual(vm.isAvailableProductsToSell().count, 3)
    }
    
    func test_1500원투입후_초코우유사먹고_0원확인() throws {
        vm.receiveBalance(coin: 1500)
        let _ = vm.receiveOrder(index: 2)
        XCTAssertEqual(vm.currentBalance(), 0)
    }

    func test_1500원투입후_콜라사먹으려하지만_실패해서_돈그대로() throws {
        vm.receiveBalance(coin: 1500)
        let _ = vm.receiveOrder(index: 1)
        XCTAssertEqual(vm.currentBalance(), 1500)
    }
    
    func test_5000원투입후_칸타타콜라사먹고_남은돈500원() throws {
        vm.receiveBalance(coin: 5000)
        let _ = vm.receiveOrder(index: 0)
        let _ = vm.receiveOrder(index: 1)
        XCTAssertEqual(vm.currentBalance(), 500)
    }
    
    func test_5000원투입후_칸타타콜라사먹고_남은품목28개() throws {
        vm.receiveBalance(coin: 5000)
        let _ = vm.receiveOrder(index: 1)
        let _ = vm.receiveOrder(index: 0)
        let count = vm.productState().reduce(0) {
            $0 + $1.1
        }
        XCTAssertEqual(count, 28)
    }
}
