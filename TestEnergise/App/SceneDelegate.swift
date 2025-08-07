//
//  SceneDelegate.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 19/07/2025.
//

import UIKit
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var serviceContainer = ServiceContainer(modelName: "DataChate")

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: scene)
        
        let chatService = serviceContainer.chatService
        let messageService = serviceContainer.messageService
        
        let historyPresenter = HistoryPresenter(chatService: chatService,
                                                messageService: messageService)
        let historyViewController = HistoryViewController()
        historyViewController.presenter = historyPresenter
        let historyTitle = NSLocalizedString("history", comment: "History chat tab bar title")
        let historyNav = UINavigationController(rootViewController: historyViewController)
        historyNav.tabBarItem = UITabBarItem(title: historyTitle, image: UIImage(systemName: "list.clipboard"), tag: 2)
        historyNav.tabBarItem.accessibilityLabel = historyTitle
        historyNav.tabBarItem.accessibilityTraits = .button
        
        
        let chatPresenter = ChatPresenter(chatService: chatService, messageService: messageService)
        let homeVC = ChatViewController()
        homeVC.presenter = chatPresenter
        let homeNav = UINavigationController(rootViewController: homeVC)
        let homeTitle = NSLocalizedString("home", comment: "Home tab bar title")
        homeNav.tabBarItem = UITabBarItem(title: homeTitle, image: UIImage(systemName: "house"), tag: 0)
        homeNav.tabBarItem.accessibilityLabel = homeTitle
        homeNav.tabBarItem.accessibilityTraits = .button
        
        let ipPresenter = IPServicePresenter()
        let ipInformationVC = InformationViewController()
        ipInformationVC.presenter = ipPresenter
        let ipInfoNav = UINavigationController(rootViewController: ipInformationVC)
        let informationTitle = NSLocalizedString("information", comment: "Ip information tab bar title")
        ipInfoNav.tabBarItem = UITabBarItem(title: informationTitle, image: UIImage(systemName: "book.fill"), tag: 1)
        ipInfoNav.tabBarItem.accessibilityLabel = informationTitle
        ipInfoNav.tabBarItem.accessibilityTraits = .button
        
        let settingsPresenter = SettingsPresenter()
        let settingsVC = SettingsViewController()
        settingsVC.presenter = settingsPresenter
        let settingsNav = UINavigationController(rootViewController: settingsVC)
        let settingsTitle = NSLocalizedString("settings", comment: "Settings tab bar title")
        settingsNav.tabBarItem = UITabBarItem(title: settingsTitle, image: UIImage(systemName: "gearshape.fill"), tag: 3)
        settingsNav.tabBarItem.accessibilityLabel = settingsTitle
        settingsNav.tabBarItem.accessibilityTraits = .button
        
        let mainTabBarController = MainTabBarController(viewControllers: [homeNav, ipInfoNav, historyNav, settingsNav])
        
        self.window?.rootViewController = mainTabBarController
        self.window?.makeKeyAndVisible()
    }

}

