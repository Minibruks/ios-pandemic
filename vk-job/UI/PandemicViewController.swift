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
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pandemicInfo.getGroupSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        cell.pandemicInfo = pandemicInfo
     
        PandemicViewController.logger.trace("idx path \(indexPath.row) and tmp: \(self.pandemicInfo.tmp[indexPath.row])")
        if pandemicInfo.tmp[indexPath.row] == false {
            cell.changeGreen()
        } else {
            cell.changeRed()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        PandemicViewController.logger.trace("SELECT \(indexPath.row)")
        pandemicInfo.tmp[indexPath.row] = true
        let cell = collectionView.cellForItem(at: indexPath) as! CustomCollectionViewCell
        cell.pandemicInfo = pandemicInfo
        
        if pandemicInfo.tmp[indexPath.row] == false {
            cell.changeGreen()
        } else {
            cell.changeRed()
        }
                
        self.startInfection(indexPath: [0, indexPath.row], period: 1.0)
    }
    
    func isAllInfected() -> Bool {
        if !pandemicInfo.finish && self.pandemicInfo.infectedSize >= self.pandemicInfo.getGroupSize() {
            pandemicInfo.finish = true
            let alert = UIAlertController(title: "Pandemic completed", message: "", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            PandemicViewController.logger.trace("FINISH")
            return true
        }
        
        return false
    }
    
    func startInfection(indexPath: IndexPath, period: Double) {
        PandemicViewController.logger.trace("🟢 Entered switch colors")
        if isAllInfected() {
            return
        }
        let n = self.pandemicInfo.getGroupSize()
        
        
        DispatchQueue.global().async {
            while !self.isAllInfected() {
                for j in 0...n - 1 {
                    let left = max(j - self.pandemicInfo.getInfectionFactor(), 0)
                    let right = min(j + self.pandemicInfo.getInfectionFactor(), n - 1)
                    if self.pandemicInfo.tmp[j] {
                        for i in left...right {
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                                if !self.isAllInfected() {
                                    let cell = self.collectionView!.cellForItem(at: [0, i]) as! CustomCollectionViewCell
                                    cell.pandemicInfo = self.pandemicInfo
                                    if !self.pandemicInfo.tmp[i] {
                                        cell.changeRed()
                                        self.pandemicInfo.tmp[i] = true
                                    }
                                }
                            }
                        }
                        Thread.sleep(forTimeInterval: 1.0)
                    }
                }
            }
        }
    }
}
