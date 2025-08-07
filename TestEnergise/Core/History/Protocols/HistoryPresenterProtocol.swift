//
//  HistoryPresenterProtocol.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 31/07/2025.
//

import Foundation

protocol HistoryPresenterProtocol: AnyObject {
    
    var view: HistoryViewProtocol? { get set }
    var previews: [ChatPreview] { get }
    
    func viewDidLoad()
    func viewWillAppear()
    func didSelectChat(at section: Int)
    func didTapDeleteChat(at section: Int)
}
