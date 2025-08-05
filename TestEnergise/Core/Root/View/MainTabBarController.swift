//
//  MainTabBarController.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 19/07/2025.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    init(viewControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers
        setupTabBarAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupTabBarAppearance() {
        
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .systemGray
        tabBar.backgroundColor = .systemBackground

    }
}
