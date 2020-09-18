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
        if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            return scene.vendingMachine
        } else { return VendingMachine() }
    }
    private var historyXCoordinate = 20
    private var historyImageViwes: [UIImageView] = []
    
    @IBOutlet var imageViews: [UIImageView]!
    @IBOutlet weak var fiveTousand: UIButton!
    @IBOutlet weak var oneTousand: UIButton!
    @IBOutlet weak var currentCoin: UILabel!
    @IBOutlet var pushButtons: [UIButton]!
    
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
        setupLabels()
        setupImages()
        setupButtons()
        setupPushButtonOnOff()
    }
    
    @objc private func multipleOfTen(sender: Notification) {
        let alert = UIAlertController(title: "알림", message: "구매목록을 지우시겠습니까?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteAction = UIAlertAction(title: "OK", style: .default, handler: historyClear)
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func historyDidChanged(sender: Notification) {
        if let purchasedItem = sender.object as? [Beverage] {
            let image = UIImageView(image: purchasedItem.last?.convertToUIImage())
            image.frame = CGRect(x: historyXCoordinate, y: 720, width: 80, height: 100)
            historyImageViwes.append(image)
            self.view.addSubview(image)
            historyXCoordinate += 40
        }
    }
    
    @objc private func didChangedBalance(sender: Notification) {
        if let coin = sender.object as? Int {
            currentCoin.text = "\(coin)원"
            setupPushButtonOnOff()
        }
    }
    
    @objc private func didChangedBeverage(sender: Notification) {
        setupPushButtonOnOff()
    }
    
    @IBAction func oneTouched(_ sender: Any) {
        machine.receiveBalance(coin: 1000)
    }
    
    @IBAction func fiveTouched(_ sender: Any) {
        machine.receiveBalance(coin: 5000)
    }    
    
    @IBAction func onTouchPushButtons(_ sender: UIButton) {
        let _ = machine.receiveOrder(index: sender.tag)
    }
    
    private func setupButtons() {
        pushButtons.enumerated().forEach { (idx, value) in
            value.tag = idx
        }
    }
    
    private func setupPushButtonOnOff() {
        let isAvailable = machine.isAvailableProductsToSell()
        zip(pushButtons, isAvailable).forEach{ (button, check) in
            let image = check ? UIImage(named: "on.png") : UIImage(named: "off.png")
            button.setBackgroundImage(image, for: .normal)
        }
    }
    
    private func setupLabels() {
        currentCoin.text = "\(machine.currentBalance())원"
    }
    
    private func setupImages() {
        let items = machine.productState()
        items.enumerated().forEach { (idx, value) in
            imageViews[idx].image = value.0.convertToUIImage()
        }
    }
    
    private func historyClear(action: UIAlertAction) {
        machine.removeHistory()
        historyImageViwes.forEach {
            $0.removeFromSuperview()
        }
        historyXCoordinate = 20
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
