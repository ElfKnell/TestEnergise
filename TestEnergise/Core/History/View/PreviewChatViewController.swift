//
//  PreviewChatViewController.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 21/07/2025.
//

import UIKit

class PreviewChatViewController: UIViewController,
                                 UICollectionViewDataSource,
                                 UICollectionViewDelegateFlowLayout {
    
    private var collectionView: UICollectionView!
    private var messages: [String] = []
    var chat: Chat!
    private let messageService = PreviewChatPresenter(messageService: MessageService())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("preview_label", comment: "")
        view.backgroundColor = .white
        setupCollectionView()
        fetchMessages()
    }
    
    func fetchMessages() {
        messages = messageService.fetchingMessages(chat)
        collectionView.reloadData()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 10, left: 16, bottom: 10, right: 16)

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")

        view.addSubview(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }

        let label = UILabel(frame: cell.contentView.bounds)
        label.text = messages[indexPath.item]
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        cell.contentView.addSubview(label)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width - 32, height: 44)
    }
}
