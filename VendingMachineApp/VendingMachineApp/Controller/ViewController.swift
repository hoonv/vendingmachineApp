//
//  ViewController.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/14.
//  Copyright © 2020 채훈기. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var machine = VendingMachine()
    private var factory = BeverageFactory()
    private var itemToIdx: [Beverage: Int] = [:]
    private var idxToItem: [Int: Beverage] = [:]
    @IBOutlet var labels: [UILabel]!
    @IBOutlet var imageViews: [UIImageView]!
    @IBOutlet var addButtons: [UIButton]!
    @IBOutlet var buyButtons: [UIButton]!
    @IBOutlet weak var fiveTousand: UIButton!
    @IBOutlet weak var oneTousand: UIButton!
    @IBOutlet weak var currentCoin: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMachine()
        setupIdx()
        setupLabels()
        setupImages()
        setupButtons()
        NotificationCenter.default.addObserver(self, selector: #selector(changedCoin),
                                               name: .didChangedCoin, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changedBeverage),
                                               name: .didChangeBeverage, object: nil)
    }
    
    @objc private func changedCoin(sender: Notification) {
        if let coin = sender.object as? Int {
            currentCoin.text = "\(coin)원"
        }
    }
    
    @objc private func changedBeverage(sender: Notification) {
        guard let object = sender.object as? [String: Any] else { return }
        guard let sample = object["sample"] as? Beverage else { return }
        guard let count = object["count"] as? Int else { return }
        guard let idx = itemToIdx[sample] else { return }
        labels[idx].text = "\(count)개"
    }
    
    @IBAction func oneTouched(_ sender: Any) {
        machine.pushCoin(of: 1000)
    }
    
    @IBAction func fiveTouched(_ sender: Any) {
        machine.pushCoin(of: 5000)
    }
    
    @IBAction func addTouched(_ sender: UIButton) {
        guard let item = idxToItem[sender.tag] else { return }
        machine.addStockBeverage(item: item)
    }
    
    @IBAction func buyTouched(_ sender: UIButton) {
        guard let item = idxToItem[sender.tag] else { return }
        let _ = machine.buyBeverage(item: item)
    }
    
    private func setupButtons() {
        addButtons.enumerated().forEach { (idx, value) in
            value.tag = idx
        }
        buyButtons.enumerated().forEach { (idx, value) in
            value.tag = idx
        }
    }
    
    private func setupIdx() {
        let items = machine.stockToSortedTuple()
        items.enumerated().forEach { (idx, item) in
            itemToIdx[item.0] = idx
            idxToItem[idx] = item.0
        }
    }
    private func setupLabels() {
        let items = machine.stockToSortedTuple()
        items.forEach {
            guard let idx = itemToIdx[$0.0] else { return }
            labels[idx].text = "\($0.1)개"
        }
    }
    
    private func setupImages() {
        let items = machine.stockToSortedTuple()
        items.forEach {
            guard let idx = itemToIdx[$0.0] else { return }
            imageViews[idx].image = classifyNameToImage(item: $0.0)
        }
    }
    
    private func classifyNameToImage(item: Beverage) -> UIImage? {
        switch item {
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
    
    private func setupMachine() {
        machine.addStockBeverages(items: factory.makeCantata(count: 1))
        machine.addStockBeverages(items: factory.makeChocoMilk(count: 3))
        machine.addStockBeverages(items: factory.makeStrawberryMilk(count: 5))
        machine.addStockBeverages(items: factory.makeGeorgia(count: 5))
        machine.addStockBeverages(items: factory.makeCider(count: 10))
        machine.addStockBeverages(items: factory.makeCoke(count: 5))
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
