//
//  HistoryViewController.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 21/07/2025.
//

import UIKit

class HistoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private var collectionView: UICollectionView!
    private let presenter = HistoryPresenter(chatService: ChatService(),
                                             messageService: MessageService())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = NSLocalizedString("history", comment: "")
        setupCollectionView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.fetchingChats()
        collectionView.reloadData()
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "messageCell")
        collectionView.register(ChatHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "chatHeader")
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.previews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.previews[section].messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "messageCell", for: indexPath)
        let message = presenter.previews[indexPath.section].messages[indexPath.item]

        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        let label = UILabel(frame: cell.contentView.bounds)
        label.text = message.text
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        cell.contentView.addSubview(label)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "chatHeader", for: indexPath) as! ChatHeaderView
        header.configure(index: indexPath.section,
                         date: presenter.previews[indexPath.section].chat.dateCreate,
                         onOpen: { [weak self] section in
            guard let self = self else { return }
            let preview = self.presenter.previews[section]
            let chatVC = PreviewChatViewController()
            chatVC.chat = preview.chat
            
            let transition = CATransition()
            transition.duration = 0.3
            transition.type = .push
            transition.subtype = .fromRight
            self.navigationController?.view.layer.add(transition, forKey: kCATransition)
            self.navigationController?.pushViewController(chatVC, animated: true)
            
        }, onDelete: { [weak self] section in
            guard let self = self else { return }
            
            self.presenter.deleteChat(at: section)
            self.collectionView.performBatchUpdates {
                self.collectionView.deleteSections(IndexSet(integer: section))
            }
        })
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width - 32, height: 44)
    }
}
