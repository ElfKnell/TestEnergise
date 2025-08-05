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
    
    var collectionView: UICollectionView!
    var activityIndicator: UIActivityIndicatorView!

    private let presenter: PreviewChatPresenterProtocol
    
    init(presenter: PreviewChatPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.view = self
        
        view.backgroundColor = .systemBackground
        
        setupCollectionView()
        setupActivityIndicator()
        
        presenter.viewDidLoad()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 10, left: 16, bottom: 10, right: 16)

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MessageChatViewCell.self, forCellWithReuseIdentifier: MessageChatViewCell.reuseIdentifier)

        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupActivityIndicator() {
        
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageChatViewCell.reuseIdentifier, for: indexPath) as? MessageChatViewCell else {
            fatalError("Unable to dequeue MessageViewCell")
        }
        
        let messageVM = presenter.messages[indexPath.item]
        cell.configure(with: messageVM)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let text = presenter.messages[indexPath.item].text else {
            return CGSize(width: 0.0, height: 0.0)
        }
        let font = UIFont.systemFont(ofSize: 17, weight: .regular)
        let maxWidth = collectionView.bounds.width - 32
        let boundingBox = text.boundingRect(with: CGSize(width: maxWidth, height: .leastNormalMagnitude),
                                            options: [.usesLineFragmentOrigin, .usesFontLeading],
                                            attributes: [.font: font],
                                            context: nil)
        let height = ceil(boundingBox.height) + 16
        
        return CGSize(width: maxWidth, height: max(height, 44))
    }
}
