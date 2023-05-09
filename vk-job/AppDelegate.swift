//
//  AppDelegate.swift
//  vk-job
//
//  Created by Павел on 09.05.2023.
//

import UIKit

fileprivate let pandemicInfo: PandemicInfo = PandemicInfo()
fileprivate let storyAssembler: StoryAssembler = StoryAssembler(pandemicInfo)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    override init() {
        super.init()
    }
        
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let rootVC = storyAssembler.setUp
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.rootViewController = rootVC
        window?.makeKeyAndVisible()
        return true
    }


}

