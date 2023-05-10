//
//  CustomCollectionViewCell.swift
//  vk-job
//
//  Created by Павел on 09.05.2023.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCollectionViewCell"
    var isInfected: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemGreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    public func changeRed() {
        contentView.backgroundColor = .systemRed
        isInfected = true
    }
    
    public func changeGreen() {
        contentView.backgroundColor = .systemGreen
    }
    
//    override var isSelected: Bool {
//        didSet {
//            if isSelected {
//                changeColour()
//                isInfected = true
//            }
//        }
//    }
}
