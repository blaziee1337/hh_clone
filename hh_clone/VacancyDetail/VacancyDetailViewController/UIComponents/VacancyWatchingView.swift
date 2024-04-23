//
//  VacancyWatchingView.swift
//  hh_clone
//
//  Created by Halil Yavuz on 06.04.2024.
//

import UIKit

class VacancyWatchingView: UIView {
    
    private let vacancyWatchingLeftView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 36/255, green: 88/255, blue: 23/255, alpha: 1)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let lookingNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private let vacancyWatchingLeftImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "vacancyLeftViewImage")
        return imageView
    }()
    
    private let vacancyWatchingRightView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 36/255, green: 88/255, blue: 23/255, alpha: 1)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let vacancyWatchedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private let vacancyWatchingEyeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "vacancyRightViewImage")
        return imageView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(vacancyWatchingLeftView)
        addSubview(vacancyWatchingRightView)
        vacancyWatchingLeftView.addSubview(vacancyWatchingLeftImage)
        vacancyWatchingLeftView.addSubview(vacancyWatchedLabel)
        vacancyWatchingRightView.addSubview(vacancyWatchingEyeImage)
        vacancyWatchingRightView.addSubview(lookingNumberLabel)
    }
    
    private func constraints() {
        NSLayoutConstraint.activate([
            vacancyWatchingLeftView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            vacancyWatchingLeftView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            vacancyWatchingLeftView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
            vacancyWatchingLeftView.heightAnchor.constraint(equalToConstant: 50),
            vacancyWatchingLeftView.widthAnchor.constraint(equalTo: vacancyWatchingRightView.widthAnchor),
            
            lookingNumberLabel.leadingAnchor.constraint(equalTo: vacancyWatchingRightView.leadingAnchor, constant: 10),
            lookingNumberLabel.topAnchor.constraint(equalTo: vacancyWatchingRightView.topAnchor, constant: 10),
            lookingNumberLabel.widthAnchor.constraint(equalToConstant: 150),
            
            vacancyWatchingLeftImage.leadingAnchor.constraint(equalTo: vacancyWatchedLabel.trailingAnchor, constant: -5),
            vacancyWatchingLeftImage.topAnchor.constraint(equalTo: vacancyWatchingLeftView.topAnchor, constant: 10),
            
            vacancyWatchingRightView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            vacancyWatchingRightView.leadingAnchor.constraint(equalTo: vacancyWatchingLeftView.trailingAnchor, constant: 10),
            vacancyWatchingRightView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
            vacancyWatchingRightView.heightAnchor.constraint(equalToConstant: 50),
            vacancyWatchingRightView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            
            vacancyWatchedLabel.topAnchor.constraint(equalTo: vacancyWatchingLeftView.topAnchor, constant: 10),
            vacancyWatchedLabel.leadingAnchor.constraint(equalTo: vacancyWatchingLeftView.leadingAnchor, constant: 10),
            
            vacancyWatchingEyeImage.topAnchor.constraint(equalTo: vacancyWatchingRightView.topAnchor, constant: 10),
            vacancyWatchingEyeImage.leadingAnchor.constraint(equalTo: lookingNumberLabel.trailingAnchor, constant: -5),
            vacancyWatchedLabel.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func setAppliedNumber(appliedNumber: Int) {
        vacancyWatchedLabel.text = "\(appliedNumber) человек уже откликнулись"
    }
    
    func setLookingNumber(lookingNumber: Int?) {
        if lookingNumber == 0 {
            vacancyWatchingRightView.isHidden = true
        }
        guard let lookingNumber = lookingNumber else {
            vacancyWatchingRightView.isHidden = true
            return
        }
        
        let remainderTen = lookingNumber % 10
        let remainderHundred = lookingNumber % 100
        
        switch remainderTen {
        case 1:
            if remainderHundred != 11 {
                lookingNumberLabel.text = "\(lookingNumber) человек сейчас смотрят"
            }
        case 2, 3, 4:
            if remainderHundred != 12 && remainderHundred != 13 && remainderHundred != 14 {
                lookingNumberLabel.text = "\(lookingNumber) человека сейчас смотрят"
            }
        default:
            break
        }
    }
}
