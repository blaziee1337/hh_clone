//
//  findEmployeeView.swift
//  hh_clone
//
//  Created by Halil Yavuz on 27.09.2024.
//

import UIKit

final class FindEmployeeView: UIView {
    
    //MARK: - UI
    
    private lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorTheme().loginInputBackground
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var findEmployeeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Поиск сотрудников"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var vacancyPostingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Размещение ваканский и доступ к базе резюме"
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var findEmployeeButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Я ищу сотрудников", for: .normal)
        button.backgroundColor = ColorTheme().findEmployeeButton
        button.layer.cornerRadius = 10
        return button
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
        addSubview(view)
        view.addSubview(findEmployeeLabel)
        view.addSubview(vacancyPostingLabel)
        view.addSubview(findEmployeeButton)
    }
    
    //MARK: - setupConstraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            findEmployeeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            findEmployeeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            vacancyPostingLabel.topAnchor.constraint(equalTo: findEmployeeLabel.bottomAnchor, constant: 8),
            vacancyPostingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            findEmployeeButton.topAnchor.constraint(equalTo: vacancyPostingLabel.bottomAnchor, constant: 16),
            findEmployeeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            findEmployeeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            findEmployeeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24)
            
        ])
    }
}
