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

    @IBOutlet weak var messageView: MessageView!
    @IBOutlet weak var fiveTousand: UIButton!
    @IBOutlet weak var oneTousand: UIButton!
    @IBOutlet weak var currentCoin: UILabel!
    @IBOutlet weak var messageButton: UIButton!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        NotificationCenter.default.addObserver(self, selector: #selector(didChangedBalance),
                                               name: .didChangedCoin, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(historyDidChanged),
                                               name: .historyDidChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(multipleOfTen),
                                               name: .mutipleOfTen, object: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBalance()
        setupMsgBtnShadow()
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
        }
    }
    
    @IBAction func oneTouched(_ sender: Any) {
        machine.receiveBalance(coin: 1000)
    }
    
    @IBAction func fiveTouched(_ sender: Any) {
        machine.receiveBalance(coin: 5000)
    }    
    
    @IBAction func msgButtonTouched(_ sender: UIButton) {
        messageView.isHidden = !messageView.isHidden
    }
    
    private func setupBalance() {
        currentCoin.text = "\(machine.currentBalance())원"
    }
    
    private func setupMsgBtnShadow() {
        messageButton.layer.shadowRadius = 4
        messageButton.layer.shadowOpacity = 0.8
        messageButton.layer.shadowColor = UIColor.blue.cgColor
        messageButton.layer.shadowOffset = CGSize(width: 0, height: 3)
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
