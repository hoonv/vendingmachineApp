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
    private var idxToItem: [Int: Beverage] = [:]
    @IBOutlet var labels: [UILabel]!
    @IBOutlet var imageViews: [UIImageView]!
    @IBOutlet var addButtons: [UIButton]!
    @IBOutlet var buyButtons: [UIButton]!
    @IBOutlet weak var fiveTousand: UIButton!
    @IBOutlet weak var oneTousand: UIButton!
    @IBOutlet weak var currentCoin: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        NotificationCenter.default.addObserver(self, selector: #selector(didChangedCoin),
                                               name: .didChangedCoin, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didChangedBeverage),
                                               name: .didChangeBeverage, object: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMachine()
        setupIdx()
        setupLabels()
        setupImages()
        setupButtons()
    }
    
    @objc private func didChangedCoin(sender: Notification) {
        if let coin = sender.object as? Int {
            currentCoin.text = "\(coin)원"
        }
    }
    
    @objc private func didChangedBeverage(sender: Notification) {
        guard let object = sender.object as? [String: Any] else { return }
        guard let sample = object["sample"] as? Beverage else { return }
        guard let count = object["count"] as? Int else { return }
        guard let idx = machine.findIndex(beverage: sample) else { return }
        labels[idx].text = "\(count)개"
    }
    
    @IBAction func oneTouched(_ sender: Any) {
        machine.receiveBalance(coin: 1000)
    }
    
    @IBAction func fiveTouched(_ sender: Any) {
        machine.receiveBalance(coin: 5000)
    }
    
    @IBAction func addTouched(_ sender: UIButton) {
        guard let item = idxToItem[sender.tag] else { return }
        machine.addProduct(beverage: item)
    }
    
    @IBAction func buyTouched(_ sender: UIButton) {
        let _ = machine.receiveOrder(index: sender.tag) 
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
        let items = machine.productState()
        items.enumerated().forEach { (idx, item) in
            idxToItem[idx] = item.0
        }
    }
    
    private func setupLabels() {
        let items = machine.productState()
        items.enumerated().forEach { (idx, value) in
            labels[idx].text = "\(value.1)개"
        }
    }
    
    private func setupImages() {
        let items = machine.productState()
        items.enumerated().forEach { (idx, value) in
            imageViews[idx].image = value.0.convertToUIImage()
        }
    }
    
    private func setupMachine() {
        machine.addProducts(beverages: factory.makeBeverages(kind: .cantata, count: 4))
        machine.addProducts(beverages: factory.makeBeverages(kind: .chocoMilk, count: 4))
        machine.addProducts(beverages: factory.makeBeverages(kind: .cider, count: 4))
        machine.addProducts(beverages: factory.makeBeverages(kind: .coke, count: 4))
        machine.addProducts(beverages: factory.makeBeverages(kind: .georgia, count: 4))
        machine.addProducts(beverages: factory.makeBeverages(kind: .strawberryMilk, count: 4))
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


extension Beverage {
    fileprivate func convertToUIImage() -> UIImage? {
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
