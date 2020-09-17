//
//  ViewController.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/14.
//  Copyright © 2020 채훈기. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var machine: VendingMachine {
        let sceneDelegate = UIApplication.shared.connectedScenes
            .first!.delegate as! SceneDelegate
        return sceneDelegate.vendingMachine!
    }
    private var historyX = 20
    private var factory = BeverageFactory()
    private var idxToItem: [Int: Beverage] = [:]
    private var historyImageViwes: [UIImageView] = []
    @IBOutlet var labels: [UILabel]!
    @IBOutlet var imageViews: [UIImageView]!
    @IBOutlet var addButtons: [UIButton]!
    @IBOutlet var buyButtons: [UIButton]!
    @IBOutlet weak var fiveTousand: UIButton!
    @IBOutlet weak var oneTousand: UIButton!
    @IBOutlet weak var currentCoin: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        NotificationCenter.default.addObserver(self, selector: #selector(didChangedBalance),
                                               name: .didChangedCoin, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didChangedBeverage),
                                               name: .didChangeBeverage, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(historyDidChanged),
                                               name: .historyDidChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(multipleOfTen),
                                               name: .mutipleOfTen, object: nil)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupIdx()
        setupLabels()
        setupImages()
        setupButtons()
    }
    
    @objc private func multipleOfTen(sender: Notification) {
        let alert = UIAlertController(title: "Your Title", message: "Your Message", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
        let deleteAction = UIAlertAction(title: "delete", style: .destructive, handler: historyClear)
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        present(alert, animated: true, completion: nil)
    }
    
    func historyClear(action: UIAlertAction) {
        machine.removeHistory()
        historyImageViwes.forEach {
            $0.removeFromSuperview()
        }
        historyX = 20
    }
    
    @objc private func historyDidChanged(sender: Notification) {
        if let purchasedItem = sender.object as? [Beverage] {
            let image = UIImageView(image: purchasedItem.last?.convertToUIImage())
            image.frame = CGRect(x: historyX, y: 700, width: 90, height: 120)
            historyImageViwes.append(image)
            self.view.addSubview(image)
            historyX += 50
        }
    }
    
    @objc private func didChangedBalance(sender: Notification) {
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
        currentCoin.text = "\(machine.currentBalance())원"
    }
    
    private func setupImages() {
        let items = machine.productState()
        items.enumerated().forEach { (idx, value) in
            imageViews[idx].image = value.0.convertToUIImage()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


extension Beverage {
    fileprivate func convertToUIImage() -> UIImage? {
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
