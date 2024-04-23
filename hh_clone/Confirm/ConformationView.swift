//
//  LogInCodeView.swift
//  hh_clone
//
//  Created by Halil Yavuz on 03.04.2024.
//

import UIKit
import Combine

final class ConformationView: UIViewController, UITextFieldDelegate {
   weak var coordinate: ConformationCoordinator!
   private let viewModel = LogInViewModel()
    
    private var cancellables = Set<AnyCancellable>()
    // MARK: - UI
    
    private let sentCodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Отправили код на "
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
     private let emailCode: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
       label.text = "Qwerty@mail.ru"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let firstTF: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "*",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.textColor = .white
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.backgroundColor = UIColor(red: 49/255, green: 50/255, blue: 52/255, alpha: 1)
        textField.layer.cornerRadius = 8
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return textField
    }()
    
    private let secondtTF: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "*",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.textColor = .white
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.backgroundColor = UIColor(red: 49/255, green: 50/255, blue: 52/255, alpha: 1)
        textField.layer.cornerRadius = 8
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return textField
    }()
    private let thirdTF: UITextField = {
        
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "*",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.textColor = .white
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.backgroundColor = UIColor(red: 49/255, green: 50/255, blue: 52/255, alpha: 1)
        textField.layer.cornerRadius = 8
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return textField
    }()
    
    private let fourthTF: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "*",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        
        textField.textColor = .white
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.backgroundColor = UIColor(red: 49/255, green: 50/255, blue: 52/255, alpha: 1)
        textField.layer.cornerRadius = 8
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return textField
    }()
    
    private let writeCodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Напишите его, чтобы подтвердить, что это вы, а не кто-то другой входит в личный кабинет"
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Подтвердить", for: .normal)
        button.backgroundColor = UIColor(red: 43/255, green: 126/255, blue: 254/255, alpha: 1)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.isUserInteractionEnabled = false
        button.alpha = 0.5
        
        return button
    }()
    
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
        constaraints()
        
        firstTF.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        secondtTF.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        thirdTF.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fourthTF.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        confirmButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        bindViewModel()
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.isHidden = true
        
    }
    
    private func bindViewModel() {
        viewModel.emailPublisher
            .sink { [weak self] email in
                self?.emailCode.text = email
            }
            .store(in: &cancellables)
    }
    private func setupUI() {
        view.addSubview(sentCodeLabel)
        view.addSubview(writeCodeLabel)
        view.addSubview(emailCode)
        view.addSubview(confirmButton)
        view.addSubview(firstTF)
        view.addSubview(secondtTF)
        view.addSubview(thirdTF)
        view.addSubview(fourthTF)
    }
    
    
    //MARK: Constraints
    
    private func constaraints() {
        
        NSLayoutConstraint.activate([
            
            sentCodeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            sentCodeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            emailCode.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            emailCode.leadingAnchor.constraint(equalTo: sentCodeLabel.trailingAnchor, constant: 5),
            
            writeCodeLabel.topAnchor.constraint(equalTo: sentCodeLabel.bottomAnchor, constant: 20),
            writeCodeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            writeCodeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
    
            firstTF.topAnchor.constraint(equalTo: writeCodeLabel.bottomAnchor, constant: 20),
            firstTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            firstTF.widthAnchor.constraint(equalToConstant: 50),
            firstTF.heightAnchor.constraint(equalToConstant: 50),
            
            secondtTF.topAnchor.constraint(equalTo: writeCodeLabel.bottomAnchor, constant: 20),
            secondtTF.leadingAnchor.constraint(equalTo: firstTF.trailingAnchor, constant: 10),
            secondtTF.widthAnchor.constraint(equalToConstant: 50),
            secondtTF.heightAnchor.constraint(equalToConstant: 50),
            
            
            thirdTF.topAnchor.constraint(equalTo: writeCodeLabel.bottomAnchor, constant: 20),
            thirdTF.leadingAnchor.constraint(equalTo: secondtTF.trailingAnchor, constant: 10),
            thirdTF.widthAnchor.constraint(equalToConstant: 50),
            thirdTF.heightAnchor.constraint(equalToConstant: 50),
            
            fourthTF.topAnchor.constraint(equalTo: writeCodeLabel.bottomAnchor, constant: 20),
            fourthTF.leadingAnchor.constraint(equalTo: thirdTF.trailingAnchor, constant: 10),
            fourthTF.widthAnchor.constraint(equalToConstant: 50),
            fourthTF.heightAnchor.constraint(equalToConstant: 50),
            
            
            confirmButton.topAnchor.constraint(equalTo: firstTF.bottomAnchor, constant: 20),
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            confirmButton.heightAnchor.constraint(equalToConstant: 50)
       
            
        ])
    }
    
    
    @objc func buttonTapped() {
        coordinate.showMainFlow()
        //appCoodrinator.showMainFlow()
        
    }
    @objc func textDidChange(textField: UITextField) {
        let text = textField.text
        if text?.count == 1 {
            switch textField {
            case firstTF:
                secondtTF.becomeFirstResponder()
            case secondtTF:
                thirdTF.becomeFirstResponder()
            case thirdTF:
                fourthTF.becomeFirstResponder()
            case fourthTF:

                fourthTF.resignFirstResponder()
                if allFieldsFilled() {
                    confirmButton.alpha = 1
                    confirmButton.isUserInteractionEnabled = true
                }
            default:
                break
            }

        }

    }
    
    private func allFieldsFilled() -> Bool {
        return !firstTF.text!.isEmpty && !secondtTF.text!.isEmpty && !thirdTF.text!.isEmpty && !fourthTF.text!.isEmpty
    }
    
   
    
    
}
