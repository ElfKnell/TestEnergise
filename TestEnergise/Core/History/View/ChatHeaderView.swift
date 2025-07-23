//
//  ChatHeaderView.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 21/07/2025.
//

import Foundation
import UIKit

class ChatHeaderView: UICollectionReusableView {
    
    private let titleLabel = UILabel()
    private let openButton = UIButton(type: .system)
    private let deleteButton = UIButton(type: .system)
    
    private var sectionIndex: Int = 0
    private var onOpenCallback: ((Int) -> Void)?
    private var onDeleteCallback: ((Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGroupedBackground
        
        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = .darkGray
        
        openButton.setTitle(NSLocalizedString("preview", comment: "title for button"), for: .normal)
        deleteButton.setTitle(NSLocalizedString("delete", comment: "title for button"), for: .normal)
        
        openButton.addTarget(self, action: #selector(openTapped), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)

        let buttonStack = UIStackView(arrangedSubviews: [openButton, deleteButton])
        buttonStack.axis = .horizontal
        buttonStack.spacing = 12
        
        let mainStack = UIStackView(arrangedSubviews: [titleLabel, buttonStack])
        mainStack.axis = .horizontal
        mainStack.distribution = .equalSpacing
        mainStack.alignment = .center
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc
    private func openTapped() {
        onOpenCallback?(sectionIndex)
    }
    
    @objc
    private func deleteTapped() {
        onDeleteCallback?(sectionIndex)
    }
    
    func configure(index: Int,
                   date: Date?,
                   onOpen: @escaping (Int) -> Void,
                   onDelete: @escaping (Int) -> Void) {
        
        sectionIndex = index
        onOpenCallback = onOpen
        onDeleteCallback = onDelete
        
        if let date {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            titleLabel.text = "🗓️ \(NSLocalizedString("created", comment: "Label for creation date")): \(formatter.string(from: date))"
        } else {
            titleLabel.text = "🗓️ \(NSLocalizedString("dateless", comment: "Label for no date"))"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
