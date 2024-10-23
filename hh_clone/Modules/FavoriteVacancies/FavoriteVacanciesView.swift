//
//  FavoriteVacanciesView.swift
//  hh_clone
//
//  Created by Halil Yavuz on 22.10.2024.
//

import UIKit
import CoreData

final class FavoriteVacanciesView: UIViewController {
    
    private var favoriteVacancies = [FavoriteVacancy]()
    private let viewModel: VacanciesViewModel
    
    init(viewModel: VacanciesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI
    
    private let favoriteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Избранное"
        label.font = .systemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    private let numberOfVacancies: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()
    
    private let vacanciesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(VacanciesCell.self, forCellReuseIdentifier: VacanciesCell.identifier)
        tableView.backgroundColor = .black
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupUI()
        setupConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabel()
        setupNavigation()
        fetchFavoriteVacancies()
    }
    
    private func setupUI() {
        view.addSubview(favoriteLabel)
        view.addSubview(numberOfVacancies)
        view.addSubview(vacanciesTableView)
        
        vacanciesTableView.delegate = self
        vacanciesTableView.dataSource = self
    }
    
    private func setupNavigation() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.isHidden = false
        
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            favoriteLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            favoriteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            numberOfVacancies.topAnchor.constraint(equalTo: favoriteLabel.bottomAnchor, constant: 24),
            numberOfVacancies.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            vacanciesTableView.topAnchor.constraint(equalTo: numberOfVacancies.bottomAnchor, constant: 16),
            vacanciesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            vacanciesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            vacanciesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)
            
        ])
    }
    
    private func fetchFavoriteVacancies() {
        favoriteVacancies = viewModel.coreDataManager.fetchFavoriteVacancies()
        print(favoriteVacancies.first?.id ?? "")
        vacanciesTableView.reloadData()
        updateLabel() 
    }
    
    private func updateLabel() {
            let count = favoriteVacancies.count
            if count == 0 {
                numberOfVacancies.text = "Нет доступных вакансий"
            } else if count == 1 {
                numberOfVacancies.text = "1 вакансия"
            } else {
                numberOfVacancies.text = "\(count) вакансий"
            }
        }
    }

extension FavoriteVacanciesView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteVacancies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VacanciesCell.identifier, for: indexPath) as? VacanciesCell else {
            return UITableViewCell()
        }
        
        let model = favoriteVacancies[indexPath.row]
        cell.configureFavorite(cell: model, viewModel: viewModel)
        cell.backgroundColor = .black
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedVacancy = viewModel.vacancies.first?.vacancies[indexPath.row] else { return }
        let vacancyDetailView = VacancyDetailView(vacancy: selectedVacancy)
        navigationController?.pushViewController(vacancyDetailView, animated: true)
    }
}
