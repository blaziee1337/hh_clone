//
//  VacancyDetailView.swift
//  hh_clone
//
//  Created by Halil Yavuz on 20.10.2024.
//

import UIKit

final class VacancyDetailView: UIViewController {
    
    private let vacancy: VacancyModel
    
    init(vacancy: VacancyModel) {
        self.vacancy = vacancy
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - UI
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let vacancyNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = .white
        return label
    }()
    
    private let salaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let experienceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let scheduleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let numberOfVacancyViewedView: NumberOfVacancyViewedView = {
        let view = NumberOfVacancyViewedView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let vacancyAdressInfoView: VacancyAdressInfoView = {
        let view = VacancyAdressInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let vacancyDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private let yourTasksLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.text = "Ваши Задачи"
        return label
    }()
    
    private let responsibilitiesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let asqQuestionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        label.text = "Задайте вопрос работодателю"
        return label
    }()
    
    private let heWillReceiveWithAResponseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "Он получит его с откликом на вакансию"
        return label
    }()
    
    private var questionButtons: [UIButton] = []
    
    private let respondButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGreen
        button.setTitle("Откликнуться", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    //MARK: - lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        configure()
        setupNavigationBar()
    }
    
    private var vacancyAdressInfoWithNumberViewConstraint: NSLayoutConstraint?
    private var vacancyAdressInfoWithoutNumberViewConstraint: NSLayoutConstraint?
    //MARK: - setupUI
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(vacancyNameLabel)
        contentView.addSubview(salaryLabel)
        contentView.addSubview(experienceLabel)
        contentView.addSubview(scheduleLabel)
        contentView.addSubview(numberOfVacancyViewedView)
        contentView.addSubview(vacancyAdressInfoView)
        contentView.addSubview(vacancyDescription)
        contentView.addSubview(yourTasksLabel)
        contentView.addSubview(responsibilitiesLabel)
        contentView.addSubview(asqQuestionLabel)
        contentView.addSubview(heWillReceiveWithAResponseLabel)
        contentView.addSubview(respondButton)
    }
    
    private func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.isHidden = false
        
        let eyeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let moreButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let isFavouriteButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        
        eyeButton.setImage(UIImage(named: "eyeImage"), for: .normal)
        moreButton.setImage(UIImage(named: "moreImage"), for: .normal)
        isFavouriteButton.setImage(UIImage(named: "favouritesfalse"), for: .normal)
        
        eyeButton.imageView?.contentMode = .scaleAspectFit
        moreButton.imageView?.contentMode = .scaleAspectFit
        isFavouriteButton.imageView?.contentMode = .scaleAspectFit
        
        let stackView = UIStackView(arrangedSubviews: [isFavouriteButton, eyeButton, moreButton])
        stackView.axis = .horizontal
        stackView.spacing = 16
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: stackView)
        
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "backButtonImage"), for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = UIColor.black
        
        navigationController?.navigationBar.standardAppearance = standardAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance
    }

    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }


    //MARK: - setupConstraints
    
    private func setupConstraints() {
        vacancyAdressInfoWithNumberViewConstraint = vacancyAdressInfoView.topAnchor.constraint(equalTo: numberOfVacancyViewedView.bottomAnchor, constant: 24)
        vacancyAdressInfoWithoutNumberViewConstraint = vacancyAdressInfoView.topAnchor.constraint(equalTo: scheduleLabel.bottomAnchor, constant: 24)

        vacancyAdressInfoWithNumberViewConstraint?.isActive = true
        vacancyAdressInfoWithoutNumberViewConstraint?.isActive = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            vacancyNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            vacancyNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            vacancyNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            salaryLabel.topAnchor.constraint(equalTo: vacancyNameLabel.bottomAnchor, constant: 16),
            salaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            salaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            experienceLabel.topAnchor.constraint(equalTo: salaryLabel.bottomAnchor, constant: 16),
            experienceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            experienceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            scheduleLabel.topAnchor.constraint(equalTo: experienceLabel.bottomAnchor, constant: 6),
            scheduleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            scheduleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            numberOfVacancyViewedView.topAnchor.constraint(equalTo: scheduleLabel.bottomAnchor, constant: 24),
            numberOfVacancyViewedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            numberOfVacancyViewedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            vacancyAdressInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            vacancyAdressInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            vacancyDescription.topAnchor.constraint(equalTo: vacancyAdressInfoView.bottomAnchor, constant: 16),
            vacancyDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            vacancyDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            yourTasksLabel.topAnchor.constraint(equalTo: vacancyDescription.bottomAnchor, constant: 16),
            yourTasksLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            responsibilitiesLabel.topAnchor.constraint(equalTo: yourTasksLabel.bottomAnchor, constant: 8),
            responsibilitiesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            responsibilitiesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            asqQuestionLabel.topAnchor.constraint(equalTo: responsibilitiesLabel.bottomAnchor, constant: 32),
            asqQuestionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            heWillReceiveWithAResponseLabel.topAnchor.constraint(equalTo: asqQuestionLabel.bottomAnchor, constant: 8),
            heWillReceiveWithAResponseLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            respondButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            respondButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            respondButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            respondButton.heightAnchor.constraint(equalToConstant: 48)
            
        ])
    }
    
    private func configure() {
        vacancyNameLabel.text = vacancy.title
        salaryLabel.text = vacancy.salary.full
        experienceLabel.text = "Требуемый опыт: \(vacancy.experience.text)"
        scheduleLabel.text = vacancy.schedules.prefix(1).map { $0.capitalized }.joined() + ", " + vacancy.schedules.dropFirst().joined(separator: ", ")
        if let appliedNumber = vacancy.appliedNumber {
            numberOfVacancyViewedView.setAppliedNumber(appliedNumber: appliedNumber)
            numberOfVacancyViewedView.isHidden = false
            vacancyAdressInfoWithNumberViewConstraint?.isActive = true
            vacancyAdressInfoWithoutNumberViewConstraint?.isActive = false
        } else {
            numberOfVacancyViewedView.isHidden = true
            vacancyAdressInfoWithNumberViewConstraint?.isActive = false
            vacancyAdressInfoWithoutNumberViewConstraint?.isActive = true
        }
        
        numberOfVacancyViewedView.setLookingNumber(lookingNumber: vacancy.lookingNumber)
        vacancyAdressInfoView.setCompanyNameLabel(name: vacancy.company)
        vacancyAdressInfoView.showLocationOnMap(address: "\(vacancy.address.town) \(vacancy.address.street.replacingOccurrences(of: "улица", with: "")) \(vacancy.address.house)")
        vacancyAdressInfoView.setAdressLabel(town: vacancy.address.town, street: vacancy.address.street, house: vacancy.address.house)
        vacancyDescription.text = vacancy.description
        responsibilitiesLabel.text = vacancy.responsibilities
        
        createQuestionButtons()
        
    }
    private func createQuestionButtons() {
        var previousButton: UIButton? = nil
        for (index, question) in vacancy.questions.enumerated() {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = ColorTheme().loginInputTF
            button.setTitle(question, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.tag = index
            button.layer.cornerRadius = 15
            button.titleLabel?.font = .systemFont(ofSize: 14)
            button.titleLabel?.numberOfLines = 0
            button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
//
            contentView.addSubview(button)
            questionButtons.append(button)
            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                button.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),
                
            ])
            
            if let previous = previousButton {
                button.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 8).isActive = true
            } else {
                button.topAnchor.constraint(equalTo: heWillReceiveWithAResponseLabel.bottomAnchor, constant: 8).isActive = true
            }
            
            previousButton = button
        }
        
        if let lastButton = previousButton {
            respondButton.topAnchor.constraint(equalTo: lastButton.bottomAnchor, constant: 16).isActive = true
        }
    }
}

