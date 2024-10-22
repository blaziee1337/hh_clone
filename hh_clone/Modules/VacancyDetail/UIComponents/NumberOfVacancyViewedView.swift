//
//  NumberOfVacancyViewedView.swift
//  hh_clone
//
//  Created by Halil Yavuz on 20.10.2024.
//

import UIKit

final class NumberOfVacancyViewedView: UIView {
    
    //MARK: - UI
    
    private let numberOfResponsesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorTheme().numberOfVacancyViewedBackground
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let numberOfResponsesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private let numberOfResponsesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "numberOfResponses")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let lookingNumberView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorTheme().numberOfVacancyViewedBackground
        view.layer.cornerRadius = 8
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
    
    private let lookingNumberImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "lookingNumber")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setupView
    
    private func setupView() {
        addSubview(numberOfResponsesView)
        numberOfResponsesView.addSubview(numberOfResponsesLabel)
        numberOfResponsesView.addSubview(numberOfResponsesImage)
        addSubview(lookingNumberView)
        lookingNumberView.addSubview(lookingNumberLabel)
        lookingNumberView.addSubview(lookingNumberImage)
    }
    
    //MARK: - setupConstraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            numberOfResponsesView.leadingAnchor.constraint(equalTo: leadingAnchor),
            numberOfResponsesView.topAnchor.constraint(equalTo: topAnchor),
            numberOfResponsesView.trailingAnchor.constraint(equalTo: lookingNumberView.leadingAnchor, constant: -8),
            numberOfResponsesView.bottomAnchor.constraint(equalTo: bottomAnchor),
          
            numberOfResponsesLabel.topAnchor.constraint(equalTo: numberOfResponsesView.topAnchor, constant: 8),
            numberOfResponsesLabel.leadingAnchor.constraint(equalTo: numberOfResponsesView.leadingAnchor, constant: 8),
            numberOfResponsesLabel.trailingAnchor.constraint(equalTo: numberOfResponsesImage.leadingAnchor, constant: -21),
            numberOfResponsesLabel.bottomAnchor.constraint(equalTo: numberOfResponsesView.bottomAnchor, constant: -8),
            
            numberOfResponsesImage.topAnchor.constraint(equalTo: numberOfResponsesView.topAnchor, constant: 8),
            numberOfResponsesImage.trailingAnchor.constraint(equalTo: numberOfResponsesView.trailingAnchor, constant: -8),
            
            lookingNumberView.topAnchor.constraint(equalTo: topAnchor),
            lookingNumberView.leadingAnchor.constraint(equalTo: numberOfResponsesView.trailingAnchor, constant: 8),
            lookingNumberView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lookingNumberView.bottomAnchor.constraint(equalTo: bottomAnchor),
            lookingNumberView.widthAnchor.constraint(equalToConstant: 170),
           
            lookingNumberLabel.topAnchor.constraint(equalTo: lookingNumberView.topAnchor, constant: 8),
            lookingNumberLabel.leadingAnchor.constraint(equalTo: lookingNumberView.leadingAnchor, constant: 8),
            lookingNumberLabel.trailingAnchor.constraint(equalTo: lookingNumberView.trailingAnchor, constant: -21),
            lookingNumberLabel.bottomAnchor.constraint(equalTo: lookingNumberView.bottomAnchor, constant: -8),
            
            lookingNumberImage.topAnchor.constraint(equalTo: lookingNumberView.topAnchor, constant: 8),
            lookingNumberImage.trailingAnchor.constraint(equalTo: lookingNumberView.trailingAnchor, constant: -8),
            
            
        ])
    }
    
    //MARK: - Public methods
    
    func setAppliedNumber(appliedNumber: Int) {
        numberOfResponsesLabel.text = "\(appliedNumber) человек уже откликнулись"
    }
    
    func setLookingNumber(lookingNumber: Int?) {
        if lookingNumber == 0 {
            lookingNumberView.isHidden = true
        }
        guard let lookingNumber = lookingNumber else {
            lookingNumberView.isHidden = true
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
