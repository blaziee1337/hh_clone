//
//  ConformationView.swift
//  hh_clone
//
//  Created by Halil Yavuz on 27.09.2024.
//

import UIKit

final class ConformationView: UIViewController {
    
    private let viewModel: ConformationViewModel
    
    //MARK: - Init
    
    init(viewModel: ConformationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI
    
    private lazy var sentCodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Отправили код на "
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private lazy var emailCode: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = viewModel.email
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private lazy var textFields: [ConformationTF] = []
    
    private lazy var writeCodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Напишите его, чтобы подтвердить, что это вы, а не кто-то другой входит в личный кабинет"
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Подтвердить", for: .normal)
        button.backgroundColor = ColorTheme().continueButton
        button.layer.cornerRadius = 8
        button.isUserInteractionEnabled = false
        button.alpha = 0.5
        return button
    }()
    
    //MARK: - lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTextFields()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           textFields.first?.becomeFirstResponder()
       }
    
    //MARK: - setupUI
    
    private func setupUI() {
        view.backgroundColor = .black
        for textField in textFields {
            view.addSubview(textField)
        }
        view.addSubview(sentCodeLabel)
        view.addSubview(emailCode)
        view.addSubview(writeCodeLabel)
        view.addSubview(confirmButton)
    }
    
    private func setupTextFields() {
        for _ in 0..<4 {
            let textField = createTextField()
            textField.delegate = self
            textField.fieldsDelegate = self
            textFields.append(textField)
            view.addSubview(textField)
            
        }
    }
    
    private func createTextField() -> ConformationTF {
        let textField = ConformationTF()
        textField.attributedPlaceholder = NSAttributedString(
            string: "*",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        textField.textColor = .white
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.backgroundColor = ColorTheme().loginInputTF
        textField.layer.cornerRadius = 8
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return textField
    }
    
    //MARK: - setupConstraints
    
    private func setupConstraints() {
        for (index, textField) in textFields.enumerated() {
            NSLayoutConstraint.activate([
                
                sentCodeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 130),
                sentCodeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
                
                emailCode.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 130),
                emailCode.leadingAnchor.constraint(equalTo: sentCodeLabel.trailingAnchor, constant: 5),
                
                writeCodeLabel.topAnchor.constraint(equalTo: sentCodeLabel.bottomAnchor, constant: 16),
                writeCodeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
                writeCodeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
                
                textField.topAnchor.constraint(equalTo: writeCodeLabel.bottomAnchor, constant: 16),
                textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(10 + (60 * index))),
                textField.widthAnchor.constraint(equalToConstant: 50),
                textField.heightAnchor.constraint(equalToConstant: 50),
                
                confirmButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
                confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
                confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
                confirmButton.heightAnchor.constraint(equalToConstant: 48)
                
            ])
        }
    }
   
    // MARK: - Update Confirm Button State
   
    private func activateConfirmButton() {
        confirmButton.isUserInteractionEnabled = true
        confirmButton.alpha = 1.0
    }
    
    private func deactivateConfirmButton() {
        confirmButton.isUserInteractionEnabled = false
        confirmButton.alpha = 0.5
    }
}

// MARK: - OTPTextFieldDelegate

extension ConformationView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentTextField = textField as? ConformationTF , let index = textFields.firstIndex(of: currentTextField) else {
            return true
        }
        
        if !string.isEmpty {
            currentTextField.text = string
            viewModel.updateCode(at: index, with: string)
            
            if index == textFields.count - 1 {
                currentTextField.resignFirstResponder()
                
                if viewModel.isCodeComplete() {
                    activateConfirmButton()
                }
            } else {
                let nextTextField = textFields[index + 1]
                nextTextField.becomeFirstResponder()
            }
            return false
            
        } else {
            viewModel.removeCode(at: index)
            
            if !viewModel.isCodeComplete() {
                deactivateConfirmButton()
            }
            return true
        }
    }
}

extension ConformationView: FieldsProtocol {
    func textFieldDidEnterBackspace(_ textField: ConformationTF) {
        // Переход на предыдущее текстовое поле при нажатии Backspace
        if let index = textFields.firstIndex(of: textField), index > 0 {
            let previousTextField = textFields[index - 1]
            previousTextField.becomeFirstResponder()
        }
    }
}
