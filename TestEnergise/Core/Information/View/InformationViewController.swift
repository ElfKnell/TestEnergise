//
//  InformationViewController.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 19/07/2025.
//

import UIKit
import MapKit

class InformationViewController: UIViewController {

    var presenter: IPServicePresenterProtocol!
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.layer.cornerRadius = 12
        mapView.layer.masksToBounds = true
        mapView.isZoomEnabled = false
        mapView.isScrollEnabled = false
        mapView.isUserInteractionEnabled = false
        return mapView
    }()
    
    lazy var detailsStackView: UIStackView = {
        let detailsStackView = UIStackView()
        detailsStackView.translatesAutoresizingMaskIntoConstraints = false
        detailsStackView.axis = .vertical
        detailsStackView.spacing = 8
        detailsStackView.alignment = .leading
        return detailsStackView
    }()
    
    lazy var reloadButton: UIButton = {
        let reloadButton = UIButton()
        reloadButton.translatesAutoresizingMaskIntoConstraints = false
        reloadButton.setTitle(NSLocalizedString("update_data", comment: ""), for: .normal)
        reloadButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        reloadButton.backgroundColor = .systemBlue
        reloadButton.setTitleColor(.white, for: .normal)
        reloadButton.layer.cornerRadius = 12
        reloadButton.layer.shadowColor = UIColor.black.cgColor
        reloadButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        reloadButton.layer.shadowOpacity = 0.3
        reloadButton.layer.shadowRadius = 4
        reloadButton.addTarget(self, action: #selector(reloadButtonTapped), for: .touchUpInside)
        return reloadButton
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("information", comment: "")
        presenter.view = self
        setupCollectionView()
        presenter.viewDidLoad()
    }

    private func setupCollectionView() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(mapView)
        contentView.addSubview(detailsStackView)
        view.addSubview(reloadButton)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: reloadButton.topAnchor, constant: -20),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            mapView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            mapView.heightAnchor.constraint(equalToConstant: 250),
            
            detailsStackView.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 20),
            detailsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            detailsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            detailsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            reloadButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            reloadButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            reloadButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            reloadButton.heightAnchor.constraint(equalToConstant: 55),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func addDetailRow(title: String, value: String?) {
        
        guard let value = value, !value.isEmpty else { return }
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .firstBaseline
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.text = title
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let valueLabel = UILabel()
        valueLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        valueLabel.text = value
        valueLabel.numberOfLines = 0
        valueLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(valueLabel)
        
        detailsStackView.addArrangedSubview(stack)
    }
    
    @objc
    private func reloadButtonTapped() {
        fetchIPInfo()
    }
    
}
