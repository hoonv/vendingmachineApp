//
//  ModalViewController.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/17.
//  Copyright © 2020 채훈기. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {

    private var machine: VendingMachine {
        let sceneDelegate = UIApplication.shared.connectedScenes
            .first!.delegate as! SceneDelegate
        return sceneDelegate.vendingMachine!
    }
    private var idxToItem: [Int: Beverage] = [:]

    @IBOutlet var itemImageViews: [UIImageView]!
    @IBOutlet var addButtons: [UIButton]!
    @IBOutlet var labels: [UILabel]!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        NotificationCenter.default.addObserver(self, selector: #selector(didChangedBeverage),
                                               name: .didChangeBeverage, object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupIdx()
        setupButtons()
        setupLabels()
        setupImages()
    }
    
    @objc private func didChangedBeverage(sender: Notification) {
        guard let object = sender.object as? [String: Any] else { return }
        guard let sample = object["sample"] as? Beverage else { return }
        guard let count = object["count"] as? Int else { return }
        guard let idx = machine.findIndex(beverage: sample) else { return }
        labels[idx].text = "\(count)개"
    }
    
    @IBAction func addButtonTouched(_ sender: UIButton) {
        guard let item = idxToItem[sender.tag] else { return }
        machine.addProduct(beverage: item)
    }
    
    private func setupButtons() {
        addButtons.enumerated().forEach { (idx, value) in
            value.tag = idx
        }
    }
    
    private func setupImages() {
        let items = machine.productState()
        items.enumerated().forEach { (idx, value) in
            itemImageViews[idx].image = value.0.convertToUIImage()
        }
    }
    
    private func setupLabels() {
        let items = machine.productState()
        items.enumerated().forEach { (idx, value) in
            labels[idx].text = "\(value.1)개"
        }
    }

    private func setupIdx() {
        let items = machine.productState()
        items.enumerated().forEach { (idx, item) in
            idxToItem[idx] = item.0
        }
    }
}
