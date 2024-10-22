//
//  VacancyAdressInfoView.swift
//  hh_clone
//
//  Created by Halil Yavuz on 20.10.2024.
//

import UIKit
import MapKit

final class VacancyAdressInfoView: UIView {
    
    //MARK: - UI
    
    private let vacancyAdressInfoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorTheme().loginInputBackground
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let companyNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let checkMarkImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "checkMark")
        return imageView
    }()
    
    private let adressMapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsCompass = true
        mapView.layer.cornerRadius = 8
        return mapView
    }()
    
    private let adressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    //MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setupUI
    
    private func setupUI() {
        addSubview(vacancyAdressInfoView)
        vacancyAdressInfoView.addSubview(companyNameLabel)
        vacancyAdressInfoView.addSubview(checkMarkImage)
        vacancyAdressInfoView.addSubview(adressMapView)
        vacancyAdressInfoView.addSubview(adressLabel)
    }
    
    //MARK: - setupConstraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            vacancyAdressInfoView.topAnchor.constraint(equalTo: topAnchor),
            vacancyAdressInfoView.leadingAnchor.constraint(equalTo: leadingAnchor),
            vacancyAdressInfoView.trailingAnchor.constraint(equalTo: trailingAnchor),
            vacancyAdressInfoView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            companyNameLabel.topAnchor.constraint(equalTo: vacancyAdressInfoView.topAnchor, constant: 12),
            companyNameLabel.leadingAnchor.constraint(equalTo: vacancyAdressInfoView.leadingAnchor, constant: 16),
            
            checkMarkImage.topAnchor.constraint(equalTo: vacancyAdressInfoView.topAnchor, constant: 15),
            checkMarkImage.leadingAnchor.constraint(equalTo: companyNameLabel.trailingAnchor, constant: 8),
            
            adressMapView.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor, constant: 8),
            adressMapView.leadingAnchor.constraint(equalTo: vacancyAdressInfoView.leadingAnchor, constant: 16),
            adressMapView.trailingAnchor.constraint(equalTo: vacancyAdressInfoView.trailingAnchor, constant: -16),
            adressMapView.heightAnchor.constraint(equalToConstant: 58),
            
            adressLabel.topAnchor.constraint(equalTo: adressMapView.bottomAnchor, constant: 8),
            adressLabel.leadingAnchor.constraint(equalTo: vacancyAdressInfoView.leadingAnchor, constant: 16),
            adressLabel.trailingAnchor.constraint(equalTo: vacancyAdressInfoView.trailingAnchor, constant: -16),
            adressLabel.bottomAnchor.constraint(equalTo: vacancyAdressInfoView.bottomAnchor, constant: -12)
            
        ])
    }
    
    // MARK: - Map Handling
    func showLocationOnMap(address: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            if let error = error {
                print("Ошибка геокодирования: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first {
                self.addAnnotationToMap(placemark: placemark)
            }
        }
    }
       /// Установка локации на карте
    private func addAnnotationToMap(placemark: CLPlacemark) {
        let coordinate = placemark.location?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = placemark.name
        adressMapView.addAnnotation(annotation)
        
        let regionRadius: CLLocationDistance = 600
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        adressMapView.setRegion(region, animated: true)
    
}
       
       
       func setCompanyNameLabel(name: String) {
           companyNameLabel.text = name
       }
       
       func setAdressLabel(town: String, street: String, house: String) {
           adressLabel.text = "\(town), \(street), \(house)"
       }
   }

