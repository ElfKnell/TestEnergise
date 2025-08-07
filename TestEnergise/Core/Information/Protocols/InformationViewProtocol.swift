//
//  InformationViewProtocol.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 06/08/2025.
//

import Foundation

protocol InformationViewProtocol: AnyObject {
    
    func fetchIPInfo()
    func clearUI()
    func updateUI(with ipInfo: IPInfoModel)
    func showErrorMessage(_ message: String)
    func showLoadingIndicator()
    func hideLoadingIndicator()
}
