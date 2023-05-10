//
//  PandemicViewController.swift
//  vk-job
//
//  Created by Павел on 09.05.2023.
//

import Foundation
import UIKit
import os

final class PandemicViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var pandemicInfo: PandemicInfo!
    var storyAssembler: StoryAssembler!
    
    struct Pair : Hashable {
        var i : Int
        var j : Bool
    }
    
    var hasIndex : Set<Pair> = []
    var current_i: Int = 0
    
//    var tmp = [Bool](repeating: false, count: 64)
    
    private var collectionView: UICollectionView?
    
    private static let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: PandemicViewController.self)
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBlue
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else {return}
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
//        self.startSwitchingColor(indexPath: [0, 2], period: 1.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pandemicInfo.getGroupSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
     
        print("idx path \(indexPath.row) and tmp: \(pandemicInfo.tmp[indexPath.row])")
        if pandemicInfo.tmp[indexPath.row] == false {
            cell.changeGreen()
        } else {
            cell.changeRed()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("SELECT \(indexPath.row)")
        pandemicInfo.tmp[indexPath.row] = true
        let cell = collectionView.cellForItem(at: indexPath) as! CustomCollectionViewCell
//        print("is infected \(cell.isInfected)")
        if pandemicInfo.tmp[indexPath.row] == false {
            cell.changeGreen()
        } else {
            cell.changeRed()
        }
        
        self.startInfection(indexPath: [0, indexPath.row], period: 1.0)
//        self.collectionView?.reloadData()
    }
    
    func isAllInfected() -> Bool {
        if self.pandemicInfo.infectedSize == self.pandemicInfo.getGroupSize() {
            return true
        }
        
        return false
    }
    
    func startInfection(indexPath: IndexPath, period: Double) {
        PandemicViewController.logger.trace("🟢 Entered switch colors")
        let n = self.pandemicInfo.getGroupSize()
        let left = min(indexPath.row - pandemicInfo.getInfectionFactor(), 0)
        let right = min(indexPath.row + pandemicInfo.getInfectionFactor(), n)
        
        DispatchQueue.global().async {
            while !self.isAllInfected() {
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                    let cell = self.collectionView!.cellForItem(at: [0, 0]) as! CustomCollectionViewCell
                    cell.changeRed()
                }
                Thread.sleep(forTimeInterval: 1.0)
            }
        }
    }
}
