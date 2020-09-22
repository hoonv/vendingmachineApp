//
//  ProductViewCell.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/21.
//  Copyright © 2020 채훈기. All rights reserved.
//

import UIKit

protocol ButtonDelegate {
    func didButtontouched(_ sender: UIButton)
}

class ProductViewCell: UICollectionViewCell {

    @IBOutlet weak var imageWrapView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pushButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    
    var delegate: ButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupImageWrap()
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTouched))
        imageView.addGestureRecognizer(tabGesture)
        imageView.isUserInteractionEnabled = true
    }
    
    private func setupImageWrap() {
        imageWrapView.backgroundColor = .systemGray5
        imageWrapView.layer.cornerRadius = imageWrapView.frame.width / 10
        
    }
    
    @objc private func imageViewTouched() {
        Speaker.speak(text: priceLabel.text ?? "" )
    }

    @IBAction func pushTouchedUp(_ sender: UIButton) {
        delegate?.didButtontouched(sender)
    }
    
}
