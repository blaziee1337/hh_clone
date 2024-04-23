//
//  VacancyViewController.swift
//  hh_clone
//
//  Created by Halil Yavuz on 06.04.2024.
//

import UIKit
import MapKit
import Combine

final class VacancyDetailViewController: UIViewController {
   
    //MARK: - UI
    
   private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let vacancyNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = 0
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
    
    private let schedulesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let vacancyWatchingView: VacancyWatchingView = {
        let view = VacancyWatchingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let vacancyMapView: VacancyMapView = {
        let view = VacancyMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 34/255, green: 35/255, blue: 37/255, alpha: 1)
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let yourTasksLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Ваши задачи"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let responsibilitiesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    private let asqQuestionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Задайте вопрос работодателю"
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private let heWillgetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Он получит его с откликом на вакансию"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor(red: 133/255, green: 134/255, blue: 136/255, alpha: 1)
        return label
    }()
    
    private let vacancyQuestionsView: VacancyQuestionView = {
        let view = VacancyQuestionView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupStackView()
        constraints()
        view.backgroundColor = .black
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTopItemsNavBar()
      
    }
   
   
    
    //MARK: - SetupView
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        view.addSubview(vacancyNameLabel)
        view.addSubview(salaryLabel)
        view.addSubview(experienceLabel)
        view.addSubview(schedulesLabel)
        view.addSubview(vacancyWatchingView)
        view.addSubview(vacancyMapView)
        view.addSubview(descriptionLabel)
        view.addSubview(yourTasksLabel)
        view.addSubview(responsibilitiesLabel)
        view.addSubview(asqQuestionLabel)
        view.addSubview(heWillgetLabel)
        view.addSubview(vacancyQuestionsView)
        
    }
    
    private func setupStackView() {
        let arrayUI = [vacancyNameLabel, salaryLabel, experienceLabel, schedulesLabel, vacancyWatchingView,vacancyMapView, descriptionLabel, yourTasksLabel, responsibilitiesLabel,asqQuestionLabel, heWillgetLabel, vacancyQuestionsView]
        for elemnt in arrayUI {
            stackView.addArrangedSubview(elemnt)
        }
        
        stackView.setCustomSpacing(5, after: experienceLabel)
        stackView.setCustomSpacing(30, after: vacancyWatchingView)
        stackView.setCustomSpacing(30, after: responsibilitiesLabel)
        stackView.setCustomSpacing(10, after: asqQuestionLabel)
        
    }
    
    private func setupTopItemsNavBar() {
          
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.isHidden = false
        let barButton = UIButton()
        let eyeButton = UIButton(frame: CGRect(x: -100, y: 0, width: 30, height: 30))
        let moreButton = UIButton(frame: CGRect(x: -50, y: 0, width: 30, height: 30))
        let isFavouriteButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        
        eyeButton.setImage(UIImage(named: "eyeImage"), for: .normal)
        moreButton.setImage(UIImage(named: "moreImage"), for: .normal)
        isFavouriteButton.setImage(UIImage(named: "favouritesfalse"), for: .normal)
        
        eyeButton.imageView?.contentMode = .scaleAspectFit
        moreButton.imageView?.contentMode = .scaleAspectFit
        isFavouriteButton.imageView?.contentMode = .scaleAspectFit
        
        barButton.addSubview(eyeButton)
        barButton.addSubview(moreButton)
        barButton.addSubview(isFavouriteButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: barButton)
        
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = UIColor.black
        
        navigationController?.navigationBar.standardAppearance = standardAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = standardAppearance
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButtonImage"), style: .plain, target: nil, action: nil)
        
        if let backImage = UIImage(named: "backButtonImage")?.withRenderingMode(.alwaysOriginal) {
            navigationController?.navigationBar.backIndicatorImage = backImage
            navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        }
    }
    
    //MARK: - Constraints
    
    private func constraints() {
        NSLayoutConstraint.activate([
            
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            vacancyWatchingView.heightAnchor.constraint(equalToConstant: 60),
            vacancyMapView.heightAnchor.constraint(equalToConstant: 150),
            
            vacancyQuestionsView.heightAnchor.constraint(equalToConstant: 150)
            
            ])
    }
    
    //MARK: - Config
    
     func configure(viewModel: VacancyDetailViewModel) {
        vacancyNameLabel.text = viewModel.title
        salaryLabel.text = viewModel.salary
        experienceLabel.text = "Требуемый опыт: \(viewModel.experience)"
        schedulesLabel.text = viewModel.schedules.prefix(1).map { $0.capitalized }.joined() + ", " + viewModel.schedules.dropFirst().joined(separator: ", ")
        if let appliedNumber = viewModel.appliedNumber {
            vacancyWatchingView.setAppliedNumber(appliedNumber: appliedNumber)
        } else {
            vacancyWatchingView.isHidden = true
            view.layoutIfNeeded()
        }
        
        vacancyWatchingView.setLookingNumber(lookingNumber: viewModel.lookingNumber)
        vacancyMapView.setCompanyNameLabel(name: viewModel.company)
        vacancyMapView.setAdressLabel(town: viewModel.town, street: viewModel.street, house: viewModel.house)
        vacancyMapView.showLocationOnMap(address: "\(viewModel.town) \(viewModel.street.replacingOccurrences(of: "улица", with: "")) \(viewModel.house)")
        descriptionLabel.text = viewModel.description
        
        responsibilitiesLabel.text = viewModel.responsibilities
        vacancyQuestionsView.setupQuestions(questions: viewModel.questions)
        
    
    }
    
    
}



