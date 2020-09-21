//
//  ProductViewController.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/21.
//  Copyright © 2020 채훈기. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    private var machine: VendingMachine {
        if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            return scene.vendingMachine
        } else { return VendingMachine() }
    }
    private var idxToItem: [Int: Beverage] = [:]
    @IBOutlet weak var ProductCollectionView: UICollectionView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        NotificationCenter.default.addObserver(self, selector: #selector(didChangedBalance),
                                               name: .didChangedCoin, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didChangedBeverage),
                                               name: .didChangeBeverage, object: nil)
    }
    
    override func viewDidLoad() {
        ProductCollectionView.delegate = self
        ProductCollectionView.dataSource = self
        let nib = UINib(nibName: "ProductViewCell", bundle: nil)
        ProductCollectionView.register(nib, forCellWithReuseIdentifier: "viewCell")
        super.viewDidLoad()
        setupIdx()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupPushButtonOnOff()
    }
    
    @objc private func didChangedBalance(sender: Notification) {
        setupPushButtonOnOff()
    }
    
    @objc private func didChangedBeverage(sender: Notification) {
        setupPushButtonOnOff()
    }

    private func setupIdx() {
        let items = machine.productState()
        items.enumerated().forEach { (idx, item) in
            idxToItem[idx] = item.0
        }
    }
    
    private func setupPushButtonOnOff() {
        let isAvailable = machine.isAvailableProductsToSell()
        let buttons = ProductCollectionView.visibleCells.map { $0 as? ProductViewCell }.compactMap{ $0?.pushButton }
        zip(buttons, isAvailable).forEach{ (button, check) in
            let image = check ? UIImage(named: "on.png") : UIImage(named: "off.png")
            button.setBackgroundImage(image, for: .normal)
        }
    }
}



extension ProductViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameWidth = self.view.frame.width
        return CGSize(width: frameWidth / 3 * 0.9, height: frameWidth / 3 * 0.9)

    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }

    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
}

extension ProductViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return machine.productState().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = ProductCollectionView.dequeueReusableCell(withReuseIdentifier: "viewCell", for: indexPath) as? ProductViewCell {
            cell.imageView.image = idxToItem[indexPath[1]]?.convertToUIImage()
            cell.pushButton.tag = indexPath[1]
            cell.priceLabel.text = "\(idxToItem[indexPath[1]]!.price)원"
            cell.delegate = self
            return cell
        }
        return UICollectionViewCell()
    }
}

extension ProductViewController: ButtonDelegate {
    func touched(_ sender: UIButton) {
        let _ = machine.receiveOrder(index: sender.tag)
    }
}
