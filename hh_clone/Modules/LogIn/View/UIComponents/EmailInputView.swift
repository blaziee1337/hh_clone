//
//  EmailInputView.swift
//  hh_clone
//
//  Created by Halil Yavuz on 27.09.2024.
//

import UIKit

final class EmailInputView: UIView {
    
    private let viewModel = LogInViewModel()
    var onContinueTapped: ((String) -> Void)?
    
    //MARK: - UI
    
    private lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorTheme().loginInputBackground
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var findJobLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " Поиск работы"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var emailInputTF: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = ColorTheme().loginInputTF
        textField.layer.cornerRadius = 8
        
        // Левая иконка
        let imageView = UIImageView(image: UIImage(named: "emailIcon"))
        imageView.contentMode = .center
        textField.leftView = imageView
        textField.leftViewMode = .always
        
        // Placeholder
        textField.attributedPlaceholder = NSAttributedString(
            string: "  Электронная почта или телефон",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        
        textField.tintColor = .gray
        textField.textColor = .white
        textField.rightView = clearButton
        textField.rightViewMode = .whileEditing
        return textField
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton(type: .custom)
        let clearImage = UIImage(named: "clearButton")
        button.setImage(clearImage, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        return button
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Продолжить", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.backgroundColor = ColorTheme().continueButton
        button.layer.cornerRadius = 8
        button.alpha = 0.5
        button.isEnabled = false
        return button
    }()
    
    private lazy var loginWithPassButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Войти с паролем", for: .normal)
        button.setTitleColor(ColorTheme().continueButton, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        return button
    }()
    
    private lazy var isValidEmailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Введен неверный email"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemRed
        label.isHidden = true
        return label
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        setupButtonActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetupUI
    
    private func setupUI() {
        addSubview(view)
        view.addSubview(findJobLabel)
        view.addSubview(emailInputTF)
        emailInputTF.addSubview(clearButton)
        view.addSubview(continueButton)
        view.addSubview(loginWithPassButton)
        view.addSubview(isValidEmailLabel)
    
    }
    
    //MARK: - SetupConstraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            findJobLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            findJobLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            emailInputTF.topAnchor.constraint(equalTo: findJobLabel.bottomAnchor, constant: 16),
            emailInputTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailInputTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailInputTF.heightAnchor.constraint(equalToConstant: 40),
            
            isValidEmailLabel.topAnchor.constraint(equalTo: emailInputTF.topAnchor, constant: -20),
            isValidEmailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
            
            continueButton.topAnchor.constraint(equalTo: emailInputTF.bottomAnchor, constant: 16),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            continueButton.widthAnchor.constraint(equalToConstant: 167),
            continueButton.heightAnchor.constraint(equalToConstant: 40),
            
            loginWithPassButton.topAnchor.constraint(equalTo: emailInputTF.bottomAnchor, constant: 27),
            loginWithPassButton.leadingAnchor.constraint(equalTo: continueButton.trailingAnchor, constant: 24),
            loginWithPassButton.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    //MARK: - setupButtonActions
    
    private func setupButtonActions() {
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        emailInputTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        clearButton.addTarget(self, action: #selector(clearTextField), for: .touchUpInside)
    }
    
    // MARK: - @objc methods
    
    @objc private func continueButtonTapped() {
        UIView.animate(withDuration: 0.3) {
            let isValid = self.viewModel.validateEmail()
            if isValid {
                self.emailInputTF.layer.borderColor = UIColor.clear.cgColor
                self.isValidEmailLabel.isHidden = true
                self.onContinueTapped?(self.viewModel.email)
                
            } else {
                self.emailInputTF.layer.borderColor = UIColor.systemRed.cgColor
                self.emailInputTF.layer.borderWidth = 1.0
                self.isValidEmailLabel.text = self.viewModel.errorMessage
                self.isValidEmailLabel.isHidden = false
            }
        }
        
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        
        emailInputTF.layer.borderColor = UIColor.clear.cgColor
        emailInputTF.layer.borderWidth = 0
        isValidEmailLabel.isHidden = true
        
        if let text = textField.text, !text.isEmpty {
            continueButton.isEnabled = true
            continueButton.alpha = 1.0
            viewModel.email = text
        } else {
            
            continueButton.isEnabled = false
            continueButton.alpha = 0.5
        }
    }
    
    @objc private func clearTextField() {
        emailInputTF.text = ""
        emailInputTF.layer.borderColor = UIColor.clear.cgColor
        emailInputTF.layer.borderWidth = 0
        isValidEmailLabel.isHidden = true
        continueButton.isEnabled = false
        continueButton.alpha = 0.5
    }
}
