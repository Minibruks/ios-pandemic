//
//  CustomCollectionViewCell.swift
//  vk-job
//
//  Created by Павел on 09.05.2023.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    static let identifier = "CustomCollectionViewCell"
    var isInfected: Bool = false
    var pandemicInfo: PandemicInfo!
    
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
        pandemicInfo.infectedSize += 1
    }
    
    public func changeGreen() {
        contentView.backgroundColor = .systemGreen
    }
}
