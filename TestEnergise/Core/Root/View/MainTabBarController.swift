//
//  MainTabBarController.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 19/07/2025.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    private func setupTabs() {
        
        let homeVC = ChatViewController()
        let ipInformationVC = InformationViewController()
        let historyVC = HistoryViewController()
        let settingsVC = SettingsViewController()
        
        homeVC.tabBarItem = UITabBarItem(title: NSLocalizedString(NSLocalizedString("home", comment: ""), comment: ""), image: UIImage(systemName: "house"), tag: 0)
        ipInformationVC.tabBarItem = UITabBarItem(title: NSLocalizedString("information", comment: ""), image: UIImage(systemName: "book.fill"), tag: 1)
        historyVC.tabBarItem = UITabBarItem(title: NSLocalizedString("history", comment: ""), image: UIImage(systemName: "list.clipboard"), tag: 2)
        settingsVC.tabBarItem = UITabBarItem(title: NSLocalizedString("settings", comment: ""), image: UIImage(systemName: "gearshape.fill"), tag: 3)
        
        let homeNav = UINavigationController(rootViewController: homeVC)
        let ipInfoNav = UINavigationController(rootViewController: ipInformationVC)
        let historyNav = UINavigationController(rootViewController: historyVC)
        let settingsNav = UINavigationController(rootViewController: settingsVC)
        
        viewControllers = [homeNav, ipInfoNav, historyNav, settingsNav]
    }
}
