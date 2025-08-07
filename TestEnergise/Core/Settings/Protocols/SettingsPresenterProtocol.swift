//
//  SettingsPresenterProtocol.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 07/08/2025.
//

import Foundation

protocol SettingsPresenterProtocol: AnyObject {
    
    var view: SettingsViewProtocol? { get set }
    
    func viewDidLoad()
    
}
