//
//  InformationViewExtension.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 06/08/2025.
//

import MapKit

extension InformationViewController: InformationViewProtocol {
    
    func fetchIPInfo() {
        presenter.fetchIPInfo(for: nil)
    }
    
    func clearUI() {
        detailsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        mapView.removeAnnotations(mapView.annotations)
        mapView.setRegion(MKCoordinateRegion(), animated: false)
    }
    
    func updateUI(with ipInfo: IPInfoModel) {
        
        detailsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        mapView.removeAnnotations(mapView.annotations)
        
        if let lat = ipInfo.latitude, let lon = ipInfo.longitude {
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 100000, longitudinalMeters: 100000)
            mapView.setRegion(region, animated: true)

            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = ipInfo.city ?? NSLocalizedString("unknown_city", comment: "")
            annotation.subtitle = ipInfo.country ?? NSLocalizedString("unknown_country", comment: "")
            mapView.addAnnotation(annotation)
        }
        
        addDetailRow(title: NSLocalizedString("IP_address", comment: ""), value: ipInfo.ip)
        addDetailRow(title: NSLocalizedString("country", comment: ""), value: ipInfo.country)
        addDetailRow(title: NSLocalizedString("country_code", comment: ""), value: ipInfo.countryCode)
        addDetailRow(title: NSLocalizedString("region", comment: ""), value: ipInfo.regionCode)
        addDetailRow(title: NSLocalizedString("city", comment: ""), value: ipInfo.city)
        addDetailRow(title: NSLocalizedString("postal_code", comment: ""), value: ipInfo.postal)
    }
    
    func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: NSLocalizedString("error", comment: ""), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showLoadingIndicator() {
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        activityIndicator.stopAnimating()
    }
    
}
