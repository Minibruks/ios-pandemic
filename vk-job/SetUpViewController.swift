//
//  SetUpViewController.swift
//  vk-job
//
//  Created by Павел on 09.05.2023.
//

import Foundation
import UIKit
import os


class SetUpViewController: UIViewController {
    var pandemicInfo: PandemicInfo!
    var storyAssembler: StoryAssembler!
    
    private static let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: SetUpViewController.self)
    )
        
    @IBOutlet weak var groupSize: UITextField!
    
    @IBOutlet weak var infectionFactor: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func StartPressed(_ sender: Any) {
        pandemicInfo.setGroupSize(newGroupSize: Int(groupSize.text!)!)
        pandemicInfo.setInfectionFactor(newInfectionFactor: Int(infectionFactor.text!)!)
        
        SetUpViewController.logger.trace("🟢 Group size was set to: \(self.pandemicInfo.getGroupSize())")
        SetUpViewController.logger.trace("🟢 Infection factor was set to: \(self.pandemicInfo.getInfectionFactor())")
        
        pandemicInfo.setFirstCellSelected(newFirstCellSelected: false)
        let vc = storyAssembler.pandemic
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
