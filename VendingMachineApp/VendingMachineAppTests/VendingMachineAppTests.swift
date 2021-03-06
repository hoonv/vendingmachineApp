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
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        vm = VendingMachine()
    }

    func test_1500원으로_살수있는_초코우유_딸기우유() throws {
        vm.receiveBalance(coin: 1500)
        let count = vm.isAvailableProductsToSell().filter{ $0 }.count
        XCTAssertEqual(count, 2)
    }

    func test_2000원으로_살수있는_칸타타빼고나머지() throws {
        vm.receiveBalance(coin: 2000)
        let count = vm.isAvailableProductsToSell().filter{ $0 }.count
        XCTAssertEqual(count, 5)
    }

    func test_2500원으로_살수있는_모든품목() throws {
        vm.receiveBalance(coin: 2500)
        let count = vm.isAvailableProductsToSell().filter{ $0 }.count

        XCTAssertEqual(count, 6)
    }
    
    func test_1500원투입후_초코우유사먹고_0원확인() throws {
        vm.receiveBalance(coin: 1500)
        let _ = vm.receiveOrder(index: 1)
        XCTAssertEqual(vm.currentBalance(), 0)
    }

    func test_1500원투입후_콜라사먹으려하지만_실패해서_돈그대로() throws {
        vm.receiveBalance(coin: 1500)
        let _ = vm.receiveOrder(index: 0)
        XCTAssertEqual(vm.currentBalance(), 1500)
    }
    
    func test_5000원투입후_칸타타콜라사먹고_남은돈500원() throws {
        vm.receiveBalance(coin: 5000)
        let _ = vm.receiveOrder(index: 0)
        let _ = vm.receiveOrder(index: 3)
        XCTAssertEqual(vm.currentBalance(), 500)
    }
    
    func test_5000원투입후_칸타타콜라사먹고_남은품목4개() throws {
        vm.receiveBalance(coin: 5000)
        let _ = vm.receiveOrder(index: 1)
        let _ = vm.receiveOrder(index: 0)
        let count = vm.productState().reduce(0) {
            $0 + $1.1
        }
        XCTAssertEqual(count, 4)
    }
    
    func test_음료아카이브() throws {
        let cantata = BeverageFactory.makeBeverage(kind: .cantata)
        let copy = try NSKeyedArchiver.archivedData(withRootObject: cantata, requiringSecureCoding: false)
        let load = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(copy) as? Cantata
        XCTAssertEqual(cantata, load)
    }
    
    func test_자판기_아카이브() throws {
        let vm = VendingMachine()
        vm.receiveBalance(bill: 1000)
        vm.receiveBalance(coin: 500)
        let copy = try NSKeyedArchiver.archivedData(withRootObject: vm, requiringSecureCoding: false)
        let load = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(copy) as? VendingMachine
        if let copyVm = load {
            XCTAssertEqual(vm.currentBalance(), copyVm.currentBalance())

        }
    }
    
    func test_자판기_아카이브_물건갯수_6개_테스트() throws {
        let vm = VendingMachine()
        let copy = try NSKeyedArchiver.archivedData(withRootObject: vm, requiringSecureCoding: false)
        let load = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(copy) as? VendingMachine
        if let copyVm = load {
            let count = vm.productState().reduce(0) { $0 + $1.1 }
            let copyCount = copyVm.productState().reduce(0) { $0 + $1.1 }
            XCTAssertEqual(count, copyCount)

        }
    }
    
    func test_자판기_아카이브_물건갯수_7개_테스트() throws {
        let vm = VendingMachine()
        vm.addProduct(beverage: BeverageFactory.makeBeverage(kind: .cantata))
        let copy = try NSKeyedArchiver.archivedData(withRootObject: vm, requiringSecureCoding: false)
        let load = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(copy) as? VendingMachine
        if let copyVm = load {
            let count = vm.productState().reduce(0) { $0 + $1.1 }
            let copyCount = copyVm.productState().reduce(0) { $0 + $1.1 }
            XCTAssertEqual(count, copyCount)

        }
    }
}
