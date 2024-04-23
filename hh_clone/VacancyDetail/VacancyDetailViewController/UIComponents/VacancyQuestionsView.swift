//
//  VacancyQuestionsView.swift
//  hh_clone
//
//  Created by Halil Yavuz on 06.04.2024.
//

import UIKit

final class VacancyQuestionView: UIView {
    
    private let firstQuestionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 49/255, green: 52/255, blue: 42/255, alpha: 1)
        button.layer.cornerRadius = 15

        return button
    }()
    
    private let secondQuestionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 49/255, green: 52/255, blue: 42/255, alpha: 1)
        button.layer.cornerRadius = 15
        
        return button
    }()
    
    private let thirdQuestionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 49/255, green: 52/255, blue: 42/255, alpha: 1)
        button.layer.cornerRadius = 15
        return button
    }()
    
    private let fourthQuestionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 49/255, green: 52/255, blue: 42/255, alpha: 1)
        button.layer.cornerRadius = 15
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(stackView)
        stackView.addArrangedSubview(firstQuestionButton)
        stackView.addArrangedSubview(secondQuestionButton)
        stackView.addArrangedSubview(thirdQuestionButton)
        stackView.addArrangedSubview(fourthQuestionButton)
    }
    
    func setupQuestions(questions: [String]) {
        if questions.count >= 1 {
            firstQuestionButton.setTitle(questions[0], for: .normal)
        }
        if questions.count >= 2 {
            secondQuestionButton.setTitle(questions[1], for: .normal)
        } else {
            secondQuestionButton.isHidden = true
            thirdQuestionButton.isHidden = true
            fourthQuestionButton.isHidden = true
        }
        
        if questions.count >= 3 {
            thirdQuestionButton.setTitle(questions[2], for: .normal)
        } else {
            thirdQuestionButton.isHidden = true
            fourthQuestionButton.isHidden = true
        }
        
        if questions.count >= 4 {
            fourthQuestionButton.setTitle(questions[3], for: .normal)
        } else {
            fourthQuestionButton.isHidden = true
        }
    }
    
   private func constraints() {
        
        NSLayoutConstraint.activate([
            
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
        stackView.topAnchor.constraint(equalTo: topAnchor),
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        
        firstQuestionButton.widthAnchor.constraint(equalToConstant: 330),
        secondQuestionButton.widthAnchor.constraint(equalToConstant: 230),
        thirdQuestionButton.widthAnchor.constraint(equalToConstant: 210),
        fourthQuestionButton.widthAnchor.constraint(equalToConstant: 210)
        
        ])
    }
}
