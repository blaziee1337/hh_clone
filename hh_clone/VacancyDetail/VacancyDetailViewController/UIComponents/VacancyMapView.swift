//
//  VacancyMapView.swift
//  Ehh_clone
//
//  Created by Halil Yavuz on 06.04.2024.
//

import UIKit
import MapKit
import Combine

final class VacancyMapView: UIView {
    private var cancellable: AnyCancellable?
    
    private let geocoder = CLGeocoder()
    
    private let companyNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let checkMark: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "checkMark")
        return imageView
    }()
    
   private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsCompass = true
        return mapView
    }()
    
   private let addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        constraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private func setupUI() {
        addSubview(companyNameLabel)
        addSubview(checkMark)
        addSubview(mapView)
        addSubview(addressLabel)
        mapView.layer.borderWidth = 1
        mapView.layer.borderColor = UIColor.clear.cgColor
        mapView.layer.cornerRadius = 10
    }
    
    private func constraint() {
        NSLayoutConstraint.activate([
            
            companyNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            companyNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            checkMark.leadingAnchor.constraint(equalTo: companyNameLabel.trailingAnchor, constant: 8),
            checkMark.centerYAnchor.constraint(equalTo: companyNameLabel.centerYAnchor),
            
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            mapView.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor, constant: 10),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            mapView.heightAnchor.constraint(equalToConstant: 70),
            
            addressLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 10),
            addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
    }
    
    func setCompanyNameLabel(name: String) {
        companyNameLabel.text = name
    }
    
    func setAdressLabel(town: String, street: String, house: String) {
        addressLabel.text = "\(town), \(street), \(house)"
    }
    
    func showLocationOnMap(address: String) {
        
        cancellable = Future<CLPlacemark?, Error> { promise in
            
            self.geocoder.geocodeAddressString(address) { (placemarks, error) in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(placemarks?.first))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { completion in
            
        }, receiveValue: { placemark in
            if let placemark = placemark {
                self.addAnnotationToMap(placemark: placemark)
            }
        })
    }
    
    private func addAnnotationToMap(placemark: CLPlacemark) {
        let coordinate = placemark.location?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = placemark.name
        mapView.addAnnotation(annotation)
        
        let regionRadius: CLLocationDistance = 10000
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(region, animated: true)
    }
}


