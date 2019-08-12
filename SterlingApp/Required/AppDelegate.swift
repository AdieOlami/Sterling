//
//  AppDelegate.swift
//  SterlingApp
//
//  Created by Olar's Mac on 8/8/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import UIKit
import netfox
import SwiftMessages
import Reachability

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let reachability = Reachability()
    static let networkMessageId = "no_network"
    
    // MARK: - SwiftMessages
    static let networkMessageView: MessageView = {
        let view = MessageView.viewFromNib(layout: .statusLine)
        view.configureContent(body: "Sterling can't reach your network")
        view.configureTheme(backgroundColor: UIColor.red, foregroundColor: .white)
        view.id = AppDelegate.networkMessageId
        return view
    }()
    
    static let networkMessageConfig: SwiftMessages.Config = {
        var config = SwiftMessages.Config()
        config.presentationStyle = .top
        config.presentationContext = .window(windowLevel: UIWindow.Level(rawValue: UIWindow.Level.statusBar.rawValue))
        config.preferredStatusBarStyle = .lightContent
        config.duration = .forever
        return config
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // This is used to get response and would only be available for debug since there is no debug here I just simply used it directly
//        if Config.buildType == .debug {
            NFX.sharedInstance().start()
//         }
        window = UIWindow(frame: UIScreen.main.bounds)
//        UITabBar.appearance().tintColor = UIColor.FAST.primary
//        window?.tintColor = UIColor.FAST.primary
        window?.rootViewController = UINavigationController(rootViewController: BaseVC())
        window?.makeKeyAndVisible()
        setup(with: application)
        return true
    }
    
    private func setup(with application: UIApplication) {
        reachability?.whenReachable = { _ in
            SwiftMessages.hide(id: AppDelegate.networkMessageId)
        }
        reachability?.whenUnreachable = { _ in
            SwiftMessages.show(config: AppDelegate.networkMessageConfig,
                               view: AppDelegate.networkMessageView)
        }
        try? reachability?.startNotifier()
    }
}
