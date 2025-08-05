//
//  ViewController.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 19/07/2025.
//

import UIKit

class ChatViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var presenter: ChatPresenterProtocol!
    
    var collectionView: UICollectionView!
    var activityIndicator: UIActivityIndicatorView!
    let inputField = UITextField()
    private let addButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = NSLocalizedString("home", comment: "")
        
        setupCollectionView()
        setupInputArea()
        setupActivityIndicator()
        
        presenter.view = self
        presenter.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter.viewDidDisappear()
        collectionView.reloadData()
        
    }
    
    private func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(MessageChatViewCell.self,
                                forCellWithReuseIdentifier: MessageChatViewCell.reuseIdentifier)
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupInputArea() {
        
        let inputContainer = UIView()
        inputContainer.translatesAutoresizingMaskIntoConstraints = false
        inputContainer.backgroundColor = .systemBackground
        view.addSubview(inputContainer)
        
        inputField.placeholder = NSLocalizedString("enter_message_placeholder", comment: "Placeholder for message input field")
        inputField.borderStyle = .roundedRect
        inputField.translatesAutoresizingMaskIntoConstraints = false
        inputField.returnKeyType = .send
        inputField.delegate = self
        inputContainer.addSubview(inputField)
        
        addButton.setTitle(NSLocalizedString("add", comment: "Send button title"), for: .normal)
        addButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        inputContainer.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            inputContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            inputContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            inputContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            inputContainer.heightAnchor.constraint(equalToConstant: 80),
            
            inputField.leadingAnchor.constraint(equalTo: inputContainer.leadingAnchor, constant: 16),
            inputField.trailingAnchor.constraint(equalTo: inputContainer.trailingAnchor, constant: -16),
            inputField.topAnchor.constraint(equalTo: inputContainer.topAnchor),
            inputField.widthAnchor.constraint(equalToConstant: 60),
            inputField.heightAnchor.constraint(equalToConstant: 40),
            
            addButton.topAnchor.constraint(equalTo: inputField.bottomAnchor),
            addButton.trailingAnchor.constraint(equalTo: inputContainer.trailingAnchor, constant: -16),
            addButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        collectionView.bottomAnchor.constraint(equalTo: inputContainer.topAnchor, constant: -8).isActive = true
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
    
    @objc
    fileprivate func sendButtonTapped() {
        
        guard let text = inputField.text, !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        presenter.sendMessage(text: text)

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageChatViewCell.reuseIdentifier, for: indexPath) as? MessageChatViewCell else {
            fatalError("Unable to dequeue MessageCell")
        }
        
        let messageVM = presenter.messages[indexPath.item]
        cell.configure(with: messageVM)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        cell.alpha = 0
        cell.transform = CGAffineTransform(translationX: 0, y: 20)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut]) {
            cell.alpha = 1
            cell.transform = .identity
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let messageVM = presenter.messages[indexPath.item]
        let dummyCell = MessageChatViewCell(frame: .zero)
        dummyCell.configure(with: messageVM)
        
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize(width: collectionView.bounds.width, height: 44)
        }
        
        let targetWidth = collectionView.bounds.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right
        let size = dummyCell.contentView.systemLayoutSizeFitting(
            CGSizeMake(targetWidth, UIView.layoutFittingCompressedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel)
        return CGSize(width: targetWidth, height: max(size.height, 44))
    }
}

extension ChatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendButtonTapped()
        textField.resignFirstResponder()
        return true
    }
}
