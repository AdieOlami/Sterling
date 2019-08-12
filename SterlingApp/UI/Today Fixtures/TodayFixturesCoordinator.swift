//
//  TodayFixturesCoordinator.swift
//  SterlingApp
//
//  Created by Olar's Mac on 8/11/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import UIKit

class TodayFixturesCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        let controller = TodayFixtures()
        controller.tabBarItem = UITabBarItem(title: "Fixtures", image: #imageLiteral(resourceName: "ball"), tag: 2)
        controller.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -6)
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() where coordinator === child {
            childCoordinators.remove(at: index)
            break
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromVC = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return  }
        if navigationController.viewControllers.contains(fromVC) {
            return
        }
        
        if let homeVC = fromVC as? TodayFixtures {
            childDidFinish(homeVC.coordinator)
        }
    }
    
}
