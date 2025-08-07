//
//  MessageChatViewCell.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 04/08/2025.
//

import UIKit

class MessageChatViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "MessageCell"
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17)
        label.textColor = .label
        return label
    }()
    
    let bubbleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(bubbleView)
        bubbleView.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            bubbleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            bubbleView.widthAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.width * 0.75),
            
            messageLabel.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 12),
            messageLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -12),
            messageLabel.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -8)
        ])
        
        leadingConstraint = bubbleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        trailingConstraint = bubbleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        messageLabel.text = nil
        leadingConstraint.isActive = false
        trailingConstraint.isActive = false
    }
    
    func configure(with message: Message) {
        
        messageLabel.text = message.text
        
        if message.isFromCurrentUser {
            bubbleView.backgroundColor = .systemBlue
            messageLabel.textColor = .white
            trailingConstraint.isActive = true
            leadingConstraint.isActive = false
        } else {
            bubbleView.backgroundColor = .systemGray5
            messageLabel.textColor = .label
            leadingConstraint.isActive = true
            trailingConstraint.isActive = false
        }
    }
}
