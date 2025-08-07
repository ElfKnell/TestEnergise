//
//  SettingsViewProtocol.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 07/08/2025.
//

import UIKit

protocol SettingsViewProtocol: AnyObject {
    
    func setupUI(with buttonViewModels: [ButtonViewModel])
    func showShareSheet(with activityItems: [Any])
    func openURL(_ url: URL)
    
}
