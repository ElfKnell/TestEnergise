//
//  IPServicePresenterProtocol.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 06/08/2025.
//

import Foundation

protocol IPServicePresenterProtocol: AnyObject {
    
    var view: InformationViewProtocol? { get set }
    
    func viewDidLoad()
    func fetchIPInfo(for ipAddress: String?)
    
}
