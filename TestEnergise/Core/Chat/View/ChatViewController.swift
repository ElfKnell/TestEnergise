//
//  ViewController.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 19/07/2025.
//

import UIKit

class ChatViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private var collectionView: UICollectionView!
    private let inputField = UITextField()
    private let addButton = UIButton(type: .system)
    var messages: [String] = []
    var presenter: ChatPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = ChatPresenter(chatService: ChatService(), messageService: MessageService())
        presenter.view = self
        
        view.backgroundColor = .white
        title = NSLocalizedString("home", comment: "")
        setupCollectionView()
        setupInputArea()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter.chat = nil
        messages = []
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
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
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
        view.addSubview(inputContainer)
        
        inputField.placeholder = "Enter message"
        inputField.borderStyle = .roundedRect
        inputField.translatesAutoresizingMaskIntoConstraints = false
        inputContainer.addSubview(inputField)
        
        addButton.setTitle(NSLocalizedString("add", comment: ""), for: .normal)
        addButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        inputContainer.addSubview(addButton)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            inputContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            inputContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            inputContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            inputContainer.heightAnchor.constraint(equalToConstant: 44),
            
            inputField.leadingAnchor.constraint(equalTo: inputContainer.leadingAnchor),
            inputField.trailingAnchor.constraint(equalTo: inputContainer.trailingAnchor),
            inputField.centerYAnchor.constraint(equalTo: inputContainer.centerYAnchor),
            inputField.heightAnchor.constraint(equalToConstant: 36),
            
            addButton.leadingAnchor.constraint(equalTo: inputField.trailingAnchor, constant: 8),
            addButton.trailingAnchor.constraint(equalTo: inputContainer.trailingAnchor),
            addButton.centerYAnchor.constraint(equalTo: inputContainer.centerYAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        collectionView.bottomAnchor.constraint(equalTo: inputContainer.topAnchor, constant: -8).isActive = true
    }
    
    @objc
    private func addButtonTapped() {
        
        guard let text = inputField.text, !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        presenter.createMessage(text: text)
        inputField.text = ""
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        cell.contentView.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        let lable = UILabel()
        lable.text = messages[indexPath.item]
        lable.textColor = .black
        lable.textAlignment = .left
        lable.frame = cell.contentView.bounds
        lable.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        cell.contentView.addSubview(lable)
        cell.layer.cornerRadius = 8
        cell.layer.masksToBounds = true
        
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
        let width = collectionView.bounds.width - 10
        return CGSize(width: width, height: 50)
    }
}

extension ChatViewController: ChatViewUpdating {
    func updateMessage(_ messages: [Message]) {
        self.messages = messages.map { $0.text ?? "" }
        collectionView.reloadData()
    }
}
