//
//  BaseVC.swift
//  SterlingApp
//
//  Created by Olar's Mac on 8/10/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import UIKit

class BaseVC: UITabBarController {
    let competitions = CompetitionCoordinator(navigationController: UINavigationController())
    let fixtures = TodayFixturesCoordinator(navigationController: UINavigationController())

    fileprivate lazy var defaultTabBarHeight = { tabBar.frame.size.height }()
    let layerGradient = CAGradientLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarConfig()
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
        
        let newTabBarHeight = defaultTabBarHeight + CGFloat(10)
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
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.backgroundColor = UIColor.white

        competitions.start()
        fixtures.start()
        viewControllers = [fixtures.navigationController, competitions.navigationController]
        selectedIndex = 0
        tabBar.barTintColor = .white
        
    }
    
}
