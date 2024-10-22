//
//  VacancyView.swift
//  hh_clone
//
//  Created by Halil Yavuz on 15.10.2024.
//

import UIKit

final class VacanciesView: UIViewController {
    var viewModel: VacanciesViewModel
    
    init(viewModel: VacanciesViewModel, height: NSLayoutConstraint) {
        self.viewModel = viewModel
        self.tableViewHeight = height
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let imagesArray: [String] = ["vacanciesRecommend", "star", "listRecommend", "star"]
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let searchTF: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = ColorTheme().loginInputTF
        textField.layer.cornerRadius = 8
        
        // Настройка изображения поиска
        let imageView = UIImageView(image: UIImage(named: "search"))
        imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        // Контейнер для левого изображения
        let leftViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        imageView.frame.origin.x = 5  // Смещение от левого края
        leftViewContainer.addSubview(imageView)
        
        textField.leftView = leftViewContainer
        textField.leftViewMode = .always
        
        // Настройка плейсхолдера
        textField.attributedPlaceholder = NSAttributedString(
            string: " Должность, ключевые слова",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        
        return textField
    }()
    
    private let filterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = ColorTheme().loginInputTF
        button.setImage(UIImage(named: "filter"), for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let recommendationCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.layer.cornerRadius = 8
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black
        collectionView.register(RecommendationCell.self, forCellWithReuseIdentifier: RecommendationCell.identifier)
        
        return collectionView
    }()
    
    private let vacanciesForULabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "Вакансии для вас"
        label.textColor = .white
        return label
    }()
    
    private let vacanciesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .black
        tableView.register(VacanciesCell.self, forCellReuseIdentifier: "VacanciesCell")
        return tableView
    }()
    
    private let moreVacanciesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemBlue
        return button
    }()
    
    private var tableViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupMoreVacanciesButton()
        setupNavigationBar()
        DispatchQueue.main.async {
            self.vacanciesTableView.reloadData()
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DispatchQueue.main.async {
            self.vacanciesTableView.reloadData()
            
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        changeTableViewHeight()
    }
        
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(searchTF)
        contentView.addSubview(filterButton)
        contentView.addSubview(recommendationCollectionView)
        contentView.addSubview(vacanciesForULabel)
        contentView.addSubview(vacanciesTableView)
        contentView.addSubview(moreVacanciesButton)
        
        recommendationCollectionView.delegate = self
        recommendationCollectionView.dataSource = self
        vacanciesTableView.delegate = self
        vacanciesTableView.dataSource = self
    }
    private func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.isHidden = true
        
        if let statusBar = UIApplication.shared.statusBarUIView {
            statusBar.backgroundColor = .black
        }
    }
    private func setupConstraints() {
        tableViewHeight = vacanciesTableView.heightAnchor.constraint(equalToConstant: 0)
        tableViewHeight.isActive = true
        
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
            
            searchTF.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            searchTF.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            searchTF.trailingAnchor.constraint(equalTo: filterButton.leadingAnchor, constant: -8),
            searchTF.heightAnchor.constraint(equalToConstant: 40),
            
            filterButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            filterButton.leadingAnchor.constraint(equalTo: searchTF.trailingAnchor, constant: 8),
            filterButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            filterButton.heightAnchor.constraint(equalToConstant: 40),
            filterButton.widthAnchor.constraint(equalToConstant: 40),
            
            recommendationCollectionView.topAnchor.constraint(equalTo: searchTF.bottomAnchor, constant: 10),
            recommendationCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            recommendationCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            recommendationCollectionView.heightAnchor.constraint(equalToConstant: 150),
            
            vacanciesForULabel.topAnchor.constraint(equalTo: recommendationCollectionView.bottomAnchor, constant: 32),
            vacanciesForULabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            vacanciesTableView.topAnchor.constraint(equalTo: vacanciesForULabel.bottomAnchor, constant: 16),
            vacanciesTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            vacanciesTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            vacanciesTableView.bottomAnchor.constraint(equalTo: moreVacanciesButton.topAnchor, constant: -24),
            
            moreVacanciesButton.topAnchor.constraint(equalTo: vacanciesTableView.bottomAnchor, constant: 24),
            moreVacanciesButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            moreVacanciesButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            moreVacanciesButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            moreVacanciesButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func setupMoreVacanciesButton() {
        
        guard let viewModel = viewModel.vacancies.first?.vacancies else { return }
        
        switch viewModel.count {
            
        case 1:
            moreVacanciesButton.setTitle("Еще \(viewModel.count) вакансия", for: .normal)
            
        case 2, 3, 4:
            moreVacanciesButton.setTitle("Еще \(viewModel.count) вакансии", for: .normal)
            
        default:
            moreVacanciesButton.setTitle("Еще \(viewModel.count) вакансий", for: .normal)
            
        }
    }
}


//MARK: - CollectionViewDelegate, CollectionViewDataSource

extension VacanciesView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.offers.first?.offers.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendationCell.identifier, for: indexPath) as? RecommendationCell else {
            return UICollectionViewCell()
        }
        guard let offer = viewModel.offers.first?.offers[indexPath.row] else { return cell }
        cell.configure(cell: offer)
        
        cell.backgroundColor = UIColor(red: 34/255, green: 35/255, blue: 37/255, alpha: 1)
        cell.setImage(imageName: imagesArray[indexPath.row])
        return cell
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout

extension VacanciesView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == recommendationCollectionView {
            return CGSize(width: 132, height: 120)
        }
        return CGSize(width: 0, height: 0)
    }
    
}


extension VacanciesView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.vacancies.first?.vacancies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VacanciesCell.identifier, for: indexPath) as? VacanciesCell else {
            return UITableViewCell()
        }
        
        guard let vacancies = viewModel.vacancies.first?.vacancies[indexPath.row] else { return cell }
        cell.configure(cell: vacancies)
        //cell.backgroundColor = UIColor(red: 34/255, green: 35/255, blue: 37/255, alpha: 1)
        cell.backgroundColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedVacancy = viewModel.vacancies.first?.vacancies[indexPath.row] else { return }
        let vacancyDetailView = VacancyDetailView(vacancy: selectedVacancy)
        navigationController?.pushViewController(vacancyDetailView, animated: true)
    }
    
    func changeTableViewHeight() {
        let contentHeight = vacanciesTableView.contentSize.height
        tableViewHeight.constant = contentHeight
        
    }
}
