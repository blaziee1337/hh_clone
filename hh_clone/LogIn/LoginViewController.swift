//
//  AuthViewController.swift
//  hh_clone
//
//  Created by Halil Yavuz on 02.04.2024.
//

import UIKit
import Combine

final class LoginViewController: UIViewController {
    
    var viewModel: LogInViewModel!
    private var cancellables = Set<AnyCancellable>()
    private var emailSubject = CurrentValueSubject<String?, Never>(nil)
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Вход в личный кабинет"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
    
    private let findJobView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 34/255, green: 35/255, blue: 37/255, alpha: 1)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let findJobLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Поиск работы"
        label.textColor = .white
        return label
    }()
    
    private let emailTF: UITextField = {
        let textField = UITextField()
        let iconView = UIView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(red: 49/255, green: 50/255, blue: 52/255, alpha: 1)
        textField.layer.cornerRadius = 10
        let imageView = UIImageView()
        let image = UIImage(named: "email")
        imageView.image = image
        textField.leftView = imageView
        textField.leftViewMode = .always
        textField.attributedPlaceholder = NSAttributedString(
            string: "Электронная почта или телефон",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        textField.tintColor = .gray
        textField.textColor = .white
        
        
        let clearButton = UIButton()
        clearButton.frame = CGRect(x: textField.frame.width - 30, y: 0, width: 0, height: 0)
        let clearImage = UIImage(named: "clear")
        clearButton.setImage(clearImage, for: .normal)
        textField.rightView = clearButton
        textField.rightViewMode = .whileEditing
        
        return textField
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Продолжить", for: .normal)
        button.backgroundColor = UIColor(red: 43/255, green: 126/255, blue: 254/255, alpha: 1)
        button.layer.cornerRadius = 10
        button.alpha = 0.5
        button.isEnabled = false
        return button
        
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Войти с паролем", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.setTitleColor(UIColor(red: 43/255, green: 126/255, blue: 254/255, alpha: 1), for: .normal)
        
        
        return button
    }()
    
    private let isValidLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Введен неверный email"
        label.textColor = .systemRed
        label.isHidden = true
        return label
    }()
    
    private let findEmployeeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 49/255, green: 50/255, blue: 52/255, alpha: 1)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let findEmployeeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Поиск сотрудников"
        label.textColor = .white
        return label
    }()
    
    private let vacancyPostingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Размщение вакансий и доступ к базе резюме"
        label.textColor = .white
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let findEmployeeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Я ищу сотрудников", for: .normal)
        button.backgroundColor = UIColor(red: 76/255, green: 178/255, blue: 78/255, alpha: 1)
        button.layer.cornerRadius = 15
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupView() {
        view.backgroundColor = .black
        view.addSubview(loginLabel)
        view.addSubview(findJobView)
        findJobView.addSubview(findJobLabel)
        findJobView.addSubview(emailTF)
        findJobView.addSubview(continueButton)
        findJobView.addSubview(loginButton)
        
        findJobView.addSubview(isValidLabel)
        view.addSubview(findEmployeeView)
        findEmployeeView.addSubview(findEmployeeLabel)
        findEmployeeView.addSubview(vacancyPostingLabel)
        findEmployeeView.addSubview(findEmployeeButton)
        constraints()
    }
    
    private func constraints() {
        NSLayoutConstraint.activate([
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            
            findJobView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            findJobView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            findJobView.widthAnchor.constraint(equalToConstant: 380),
            findJobView.heightAnchor.constraint(equalToConstant: 179),
            
            findJobLabel.topAnchor.constraint(equalTo: findJobView.topAnchor, constant: 20),
            findJobLabel.leadingAnchor.constraint(equalTo: findJobView.leadingAnchor, constant: 20),
            
            emailTF.topAnchor.constraint(equalTo: findJobLabel.bottomAnchor, constant: 10),
            emailTF.leadingAnchor.constraint(equalTo: findJobView.leadingAnchor, constant: 20),
            emailTF.heightAnchor.constraint(equalToConstant: 40),
            emailTF.trailingAnchor.constraint(equalTo: findJobView.trailingAnchor, constant: -20),
            
            
            continueButton.topAnchor.constraint(equalTo: emailTF.bottomAnchor, constant: 30),
            continueButton.leadingAnchor.constraint(equalTo: findJobView.leadingAnchor, constant: 15),
            continueButton.widthAnchor.constraint(equalToConstant: 200),
            continueButton.heightAnchor.constraint(equalToConstant: 40),
            
            loginButton.topAnchor.constraint(equalTo: emailTF.bottomAnchor, constant: 35),
            
            loginButton.leadingAnchor.constraint(equalTo: continueButton.trailingAnchor, constant: 15),
            loginButton.widthAnchor.constraint(equalToConstant: 130),
            
            isValidLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            isValidLabel.topAnchor.constraint(equalTo: emailTF.bottomAnchor, constant: 10),
            
            findEmployeeView.topAnchor.constraint(equalTo: findJobView.bottomAnchor, constant: 50),
            findEmployeeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            findEmployeeView.widthAnchor.constraint(equalToConstant: 380),
            findEmployeeView.heightAnchor.constraint(equalToConstant: 150),
            
            findEmployeeLabel.topAnchor.constraint(equalTo: findEmployeeView.topAnchor, constant: 20),
            findEmployeeLabel.leadingAnchor.constraint(equalTo: findEmployeeView.leadingAnchor, constant: 15),
            
            vacancyPostingLabel.topAnchor.constraint(equalTo: findEmployeeLabel.bottomAnchor, constant: 10),
            vacancyPostingLabel.leadingAnchor.constraint(equalTo: findEmployeeView.leadingAnchor, constant: 15),
            
            findEmployeeButton.topAnchor.constraint(equalTo: vacancyPostingLabel.bottomAnchor, constant: 15),
            findEmployeeButton.leadingAnchor.constraint(equalTo: findEmployeeView.leadingAnchor, constant: 15),
            findEmployeeButton.widthAnchor.constraint(equalToConstant: 350)
            
        ])
    }
    
    @objc func continueButtonTapped() {
        viewModel.goToConfirm()
        
    }
    
    private func bindViewModel() {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: emailTF)
            .map { ($0.object as! UITextField).text ?? "" }
            .assign(to: \.email , on: viewModel)
            .store(in: &cancellables)
        
        
        viewModel.isValidEmail
        
            .sink { isValid in
                self.continueButton.isEnabled = isValid
                self.continueButton.alpha = isValid ? 1.0 : 0.5
            }
            .store(in: &cancellables)
        
    }
    
}


