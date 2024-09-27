//
//  LogInView.swift
//  hh_clone
//
//  Created by Halil Yavuz on 27.09.2024.
//

import UIKit

final class LogInView: UIViewController {
    
    //MARK: - UI
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Вход в личный кабинет"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
    
    private lazy var emailInputView = EmailInputView()
    private lazy var findEmployeeView = FindEmployeeView()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        view.backgroundColor = .black
    }
    
    //MARK: - setupUI
    
    private func setupUI() {
        view.addSubview(loginLabel)
        view.addSubview(emailInputView)
        view.addSubview(findEmployeeView)
    }
    
    //MARK: - setupConstraints
    
    private func setupConstraints() {
        emailInputView.translatesAutoresizingMaskIntoConstraints = false
        findEmployeeView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            emailInputView.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 144),
            emailInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailInputView.heightAnchor.constraint(equalToConstant: 179),
            
            findEmployeeView.topAnchor.constraint(equalTo: emailInputView.bottomAnchor, constant: 16),
            findEmployeeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            findEmployeeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            findEmployeeView.heightAnchor.constraint(equalToConstant: 141)
            
        ])
    }
    
}
