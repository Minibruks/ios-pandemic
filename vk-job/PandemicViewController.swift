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
        self.startSwitchingColor(indexPath: [0, 0], period: 1.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pandemicInfo.getGroupSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("SELECT \(indexPath)")
        let cell = collectionView.cellForItem(at: indexPath) as! CustomCollectionViewCell
        print("is infected \(cell.isInfected)")
    }
    
    func switchCellColor(_ collectionView: UICollectionView, indexPath: IndexPath) {
//            let cell = collectionView.cellForItem(at: indexPath)
            if collectionView.cellForItem(at: indexPath) != nil {
                if collectionView.cellForItem(at: indexPath)!.backgroundColor == .systemGreen {
                    collectionView.cellForItem(at: indexPath)!.backgroundColor = .systemRed
                }
        }
    }
    
    func startSwitchingColor(indexPath: IndexPath, period: Double) {
        PandemicViewController.logger.trace("🟢 Entered switch colors")
        let n = self.pandemicInfo.getGroupSize()
        
        
        DispatchQueue.global().async {
            for i in 0...n {
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                    let cell = self.collectionView!.cellForItem(at: [0, i]) as! CustomCollectionViewCell
                    print(i)
                    cell.changeColour()
                    self.collectionView!.reloadData()
//                    print(self.collectionView!.cellForItem(at: [0, i]).isInfected)
//                    self.switchCellColor(self.collectionView!, indexPath: IndexPath(item: i, section: 0))
//                    if self.collectionView!.cellForItem(at: IndexPath(item: i, section: 0))! == .systemGreen {
//                        self.collectionView!.cellForItem(at: IndexPath(item: i, section: 0))!.backgroundColor = .systemRed
//                    } else {
//                        print(i)
//                    }
                }
                Thread.sleep(forTimeInterval: 1.0)
            }
        }

    }
}
