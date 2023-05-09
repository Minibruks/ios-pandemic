//
//  StoryAssembler.swift
//  vk-job
//
//  Created by Павел on 09.05.2023.
//

import Foundation
import UIKit

final class StoryAssembler {
    private let pandemicInfo: PandemicInfo
    
    init(_ pandemicInfo: PandemicInfo) {
        self.pandemicInfo = pandemicInfo
    }
    
    var setUp: UINavigationController {
        let controller = Storyboard.main.instantiateViewController(withIdentifier: "SetUpViewController") as! SetUpViewController
        controller.pandemicInfo = pandemicInfo
        controller.storyAssembler = self
        let navController = UINavigationController(rootViewController: controller)
        return navController
    }
    
    var pandemic: PandemicViewController {
        let controller = Storyboard.main.instantiateViewController(withIdentifier: "PandemicViewController") as! PandemicViewController
        controller.modalTransitionStyle = .coverVertical
        controller.modalPresentationStyle = .overFullScreen
        controller.pandemicInfo = pandemicInfo
        controller.storyAssembler = self
        return controller
    }
}
