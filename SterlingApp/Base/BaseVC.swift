//
//  BaseVC.swift
//  Fast
//
//  Created by Olar's Mac on 7/4/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import UIKit

class BaseVC: UITabBarController {
    let home = HomeCoordinator(navigationController: UINavigationController())
    let shortcuts = ShortcutsCoordinator(navigationController: UINavigationController())
    let settings = SettingsCoordinator(navigationController: UINavigationController())
    let menu = MenuCoordinator(navigationController: UINavigationController())
    fileprivate lazy var defaultTabBarHeight = { tabBar.frame.size.height }()
    let layerGradient = CAGradientLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarConfig()
        log(KeyChainStorage.instance.getCurrentUser(), .json)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let newTabBarHeight = defaultTabBarHeight + CGFloat(46)
        var newFrame = tabBar.frame
        newFrame.size.height = newTabBarHeight
        newFrame.origin.y = view.frame.size.height - newTabBarHeight
        
        tabBar.frame = newFrame
    }
    
    fileprivate func tabBarConfig() {
        self.tabBar.layer.shadowOpacity = 0.1
        self.tabBar.layer.shadowOffset = CGSize.zero
        self.tabBar.layer.shadowColor = UIColor.gray.cgColor
        self.tabBar.layer.borderWidth = 0
        self.tabBar.layer.borderColor = UIColor.white.cgColor
        self.tabBar.unselectedItemTintColor = UIColor.FAST.tabColor
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.backgroundColor = UIColor.white

        home.start()
//        shortcuts.start()
        settings.start()
        menu.start()
        viewControllers = [home.navigationController, /*shortcuts.navigationController, */settings.navigationController,  menu.navigationController]
        selectedIndex = 0
        tabBar.barTintColor = .white
        
    }
    
}

class AppNavigationController: UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        isMotionEnabled = true
        motionNavigationTransitionType = .zoom
    }
}
