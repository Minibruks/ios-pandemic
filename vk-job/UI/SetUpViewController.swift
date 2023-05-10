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
    
    @IBOutlet weak var timer: UITextField!
    @IBOutlet weak var StartButton: UIButton!
    
    var groupSizeSet: Bool = false
    var infectionFactorSet: Bool = false
    var timerSet: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blockBotton()
        groupSize.addTarget(self, action: #selector(groupSizeDidChange), for: UIControl.Event.editingChanged)
        infectionFactor.addTarget(self, action: #selector(infectionFactorDidChange), for: UIControl.Event.editingChanged)
        timer.addTarget(self, action: #selector(timerDidChange), for: UIControl.Event.editingChanged)
    }
    
    private func blockBotton() {
        StartButton.alpha = 0.5
        StartButton.isEnabled = false
    }
    
    private func unblockBotton() {
        StartButton.alpha = 1
        StartButton.isEnabled = true
    }
    
    @objc func groupSizeDidChange(_ textField: UITextField) {
        if Int(textField.text!) != nil {
            groupSizeSet = true
            if groupSizeSet && infectionFactorSet && timerSet {
                unblockBotton()
            }
        } else {
            blockBotton()
        }
    }
    
    @objc func infectionFactorDidChange(_ textField: UITextField) {
        if Int(textField.text!) != nil {
            infectionFactorSet = true
            if groupSizeSet && infectionFactorSet && timerSet {
                unblockBotton()
            }
        } else {
            blockBotton()
        }
    }
    
    @objc func timerDidChange(_ textField: UITextField) {
        if Int(textField.text!) != nil {
            timerSet = true
            if groupSizeSet && infectionFactorSet && timerSet {
                unblockBotton()
            }
        } else {
            blockBotton()
        }
    }
    
    @IBAction func StartPressed(_ sender: Any) {
        pandemicInfo.setGroupSize(newGroupSize: Int(groupSize.text!)!)
        pandemicInfo.setInfectionFactor(newInfectionFactor: Int(infectionFactor.text!)!)
        pandemicInfo.setTimer(newTimer: Int(timer.text!)!)
        
        SetUpViewController.logger.trace("🟢 Group size was set to: \(self.pandemicInfo.getGroupSize())")
        SetUpViewController.logger.trace("🟢 Infection factor was set to: \(self.pandemicInfo.getInfectionFactor())")
        SetUpViewController.logger.trace("🟢 Timer was set to: \(self.pandemicInfo.getTimer())")
        
        pandemicInfo.setFirstCellSelected(newFirstCellSelected: false)
        let vc = storyAssembler.pandemic
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
