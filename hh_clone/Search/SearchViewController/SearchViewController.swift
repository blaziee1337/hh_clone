//
//  SearchViewController.swift
//  hh_clone
//
//  Created by Halil Yavuz on 03.04.2024.
//

import UIKit
import Combine

final class SearchViewController: UIViewController {
        
    var viewModel = SearchViewModel()
    var vacanciesCollectionViewHeight: NSLayoutConstraint!
 
    private var cancellables = Set<AnyCancellable>()
    private let imagesArray: [String] = ["vacanciesRecommend", "star", "listRecommend", "star"]
    
    //MARK: - UI
    
    private let searchTF: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(red: 49/255, green: 50/255, blue: 52/255, alpha: 1)
        textField.layer.cornerRadius = 10
        
        let imageView = UIImageView()
        let image = UIImage(named: "search")
        imageView.image = image
        textField.leftViewMode = .always
        textField.attributedPlaceholder = NSAttributedString(
            string: " Должность, ключевые слова",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        let leftViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        
        imageView.frame.origin.x = 10
        leftViewContainer.addSubview(imageView)
        textField.leftView = leftViewContainer
        return textField
    }()
    
    private let filterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 49/255, green: 50/255, blue: 52/255, alpha: 1)
        button.setImage(UIImage(named: "filter"), for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let recommendationCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.layer.cornerRadius = 10
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black
        collectionView.register(RecommendationViewCell.self, forCellWithReuseIdentifier: RecommendationViewCell.identifier)
        
        return collectionView
    }()
    
    private let vacanciesForULabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 25)
        label.text = "Вакансии для вас"
        label.textColor = .white
        return label
    }()
    
    private let vacanciesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black
        collectionView.register(VacanciesViewCell.self, forCellWithReuseIdentifier: VacanciesViewCell.identifier)
        return collectionView
    }()
    
    private let showMoreVacancies: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 43/255, green: 126/255, blue: 254/255, alpha: 1)
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        super.viewDidLoad()
        configureView()
        constraints()
        setupCollectionView()
        setupMoreVacanciesButton()
        bindViewModelVacancies()
        bindViewModelRecommend()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bindViewModelVacancies()
      
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        changeCollectionHeight()
    }
    
    private func setupCollectionView() {
        recommendationCollectionView.delegate = self
        recommendationCollectionView.dataSource = self
        vacanciesCollectionView.delegate = self
        vacanciesCollectionView.dataSource = self
    }
    
    private func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.isHidden = true
       
         if let statusBar = UIApplication.shared.statusBarUIView {
            statusBar.backgroundColor = .black
         }
    }
    
    //MARK: - Binding
    
    private func bindViewModelVacancies() {
        
         viewModel.$vacancies
            .receive(on: DispatchQueue.main)
             .sink { [weak self] _ in
                 self?.vacanciesCollectionView.reloadData()
                 self?.setupMoreVacanciesButton()
                 
             }
             .store(in: &cancellables)
         
         
     }
    
    private func bindViewModelRecommend() {
        viewModel.$offers
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.recommendationCollectionView.reloadData()
                
            }
            .store(in: &cancellables)
    }
     
    
    //MARK: Constraints
    
    private func constraints() {
        vacanciesCollectionViewHeight = vacanciesCollectionView.heightAnchor.constraint(equalToConstant: 0)
        vacanciesCollectionViewHeight.isActive = true
        
        
        NSLayoutConstraint.activate([

            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: -10),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            searchTF.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            searchTF.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            searchTF.heightAnchor.constraint(equalToConstant: 40),
            
            filterButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            filterButton.leadingAnchor.constraint(equalTo: searchTF.trailingAnchor, constant: 10),
            filterButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            filterButton.heightAnchor.constraint(equalToConstant: 40),
            
            filterButton.widthAnchor.constraint(equalToConstant: 40),
            
            recommendationCollectionView.topAnchor.constraint(equalTo: searchTF.bottomAnchor, constant: 10),
            
            recommendationCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            recommendationCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            recommendationCollectionView.heightAnchor.constraint(equalToConstant: 140),
            
            
            vacanciesForULabel.topAnchor.constraint(equalTo: recommendationCollectionView.bottomAnchor, constant: 20),
            vacanciesForULabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            vacanciesCollectionView.topAnchor.constraint(equalTo: vacanciesForULabel.bottomAnchor, constant: 10),
            vacanciesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            vacanciesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
        
            showMoreVacancies.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            showMoreVacancies.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            showMoreVacancies.topAnchor.constraint(equalTo: vacanciesCollectionView.bottomAnchor, constant: 30),
            showMoreVacancies.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            showMoreVacancies.heightAnchor.constraint(equalToConstant: 50)
            
            
        ])
    }
    //MARK: - Private methods
    
    private func configureView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(searchTF)
        contentView.addSubview(filterButton)
        contentView.addSubview(recommendationCollectionView)
        contentView.addSubview(vacanciesForULabel)
        contentView.addSubview(vacanciesCollectionView)
        contentView.addSubview(showMoreVacancies)
        
    }
    
    private func setupMoreVacanciesButton() {
        
        let viewModel = viewModel.vacancies
        
        switch viewModel.count {
            
        case 1:
            showMoreVacancies.setTitle("Еще \(viewModel.count) вакансия", for: .normal)
            
        case 2, 3, 4:
            showMoreVacancies.setTitle("Еще \(viewModel.count) вакансии", for: .normal)
            
        default:
            showMoreVacancies.setTitle("Еще \(viewModel.count) вакансий", for: .normal)
            
        }
    }
}

//MARK: - CollectionViewDelegate, CollectionViewDataSource

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == recommendationCollectionView {
            return viewModel.offers.count
            
        } else if collectionView == vacanciesCollectionView {
            return viewModel.vacancies.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == recommendationCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendationViewCell.identifier, for: indexPath) as? RecommendationViewCell else {
                return UICollectionViewCell()
                
            }
            let offer = viewModel.offers[indexPath.row]
            cell.configure(cellModel: RecommendCellModel.init(titlle: offer.title))
            
            cell.backgroundColor = UIColor(red: 34/255, green: 35/255, blue: 37/255, alpha: 1)
            cell.setImage(imageName: imagesArray[indexPath.row])
            
            if indexPath.row == 1 {
                cell.setRecommendUpButton(text: "Поднять")
            } else {
                cell.hideButton()
            }
            
            return cell
        } else if collectionView == vacanciesCollectionView {
            guard let cell = vacanciesCollectionView.dequeueReusableCell(withReuseIdentifier: VacanciesViewCell.identifier, for: indexPath) as? VacanciesViewCell else {
                return UICollectionViewCell()
            }
            
            
            if indexPath.row < viewModel.vacancies.count {
                let model = viewModel.vacancies[indexPath.row]
                cell.configure(cellViewModel: VacancyCellViewModel(viewModel: model))
                
            }
            cell.backgroundColor = UIColor(red: 34/255, green: 35/255, blue: 37/255, alpha: 1)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        if collectionView == vacanciesCollectionView {
            let viewModel = viewModel.vacancies[indexPath.row]
            let selectedVacancyViewModel = VacancyDetailViewModel(vacancyViewModel: viewModel)
            
            let vacancyDetailVC = VacancyDetailViewController()
            vacancyDetailVC.configure(viewModel: selectedVacancyViewModel)
            navigationController?.pushViewController(vacancyDetailVC, animated: true)
        
        }
    }
    
    func changeCollectionHeight() {
        let contentHeight = vacanciesCollectionView.collectionViewLayout.collectionViewContentSize.height
        vacanciesCollectionViewHeight.constant = contentHeight
        
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == recommendationCollectionView {
            return CGSize(width: 150, height: 130)
        } else if collectionView == vacanciesCollectionView {
            return CGSize(width: 380, height: 270)//280)
        }
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 15
    }
}




