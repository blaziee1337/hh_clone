//
//  FavouriteVacancyViewController.swift
//  hh_clone
//
//  Created by Halil Yavuz on 07.04.2024.
//

import UIKit
import CoreData

final class FavouriteVacancyViewController: UIViewController {
    
   private let context = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
    private var model = [FavouriteVacancy]()
    private let viewModel = SearchViewModel()
    
   private var favouriteCollectionViewHeight: NSLayoutConstraint!
    
    //MARK: - UI
    
    private let favouriteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Избранное"
        label.font = .boldSystemFont(ofSize: 35)
        return label
    }()
    
    private let vacanciesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 133/255, green: 134/255, blue: 136/255, alpha: 1)
        
        return label
    }()
    
    private let favouriteVacancyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black
        collectionView.register(VacanciesViewCell.self, forCellWithReuseIdentifier: VacanciesViewCell.identifier)
        return collectionView
    }()
        
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        constraints()
        updateLabel()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getModels()
        updateLabel()
        setupNavigation()
       
    }
    
    
    private func setupView() {
       
        favouriteVacancyCollectionView.delegate = self
        favouriteVacancyCollectionView.dataSource = self
        view.addSubview(favouriteLabel)
        view.addSubview(vacanciesLabel)
        view.addSubview(favouriteVacancyCollectionView)
    }
    
    private func setupNavigation() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.isHidden = false
        
    }
    
        // MARK: - Get models from Core Data
        
    private func getModels() {
        do {
            let fetchRequest: NSFetchRequest<FavouriteVacancy> = FavouriteVacancy.fetchRequest()
            self.model = try context.fetch(fetchRequest)
            DispatchQueue.main.async { [weak self] in
                self?.favouriteVacancyCollectionView.reloadData()
                self?.updateLabel()
            }
        } catch {
            print("Error fetching models: \(error)")
        }
    }
    
    private func constraints() {
        
        NSLayoutConstraint.activate([
            favouriteLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            favouriteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                        
            vacanciesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            vacanciesLabel.topAnchor.constraint(equalTo: favouriteLabel.bottomAnchor, constant: 15),
            
            favouriteVacancyCollectionView.topAnchor.constraint(equalTo: vacanciesLabel.bottomAnchor, constant: 15),
            favouriteVacancyCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            favouriteVacancyCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favouriteVacancyCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
        
    }
    
    private func updateLabel() {
        
        let count = favouriteVacancyCollectionView.numberOfItems(inSection: 0)
        if count == 0 {
            vacanciesLabel.text = "Нет доступных вакансий"
        } else if count == 1 {
            vacanciesLabel.text = "1 вакансия"
        } else {
            vacanciesLabel.text = "\(count) вакансий"
        }
    }
}

extension FavouriteVacancyViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VacanciesViewCell.identifier, for: indexPath) as? VacanciesViewCell else {
            return UICollectionViewCell()
        }
        
        let model = model[indexPath.row]
        cell.configureFavourite(cellViewModel: model)
        cell.backgroundColor = UIColor(red: 34/255, green: 35/255, blue: 37/255, alpha: 1)
        return cell
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        let viewModel = viewModel.vacancies[indexPath.row]
        let vacancyVC = VacancyDetailViewController()
        let selectedVacancyViewModel = VacancyDetailViewModel(vacancyViewModel: viewModel)
        navigationController?.pushViewController(vacancyVC, animated: true)
        vacancyVC.configure(viewModel: selectedVacancyViewModel)
       
    }
    

}

extension FavouriteVacancyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 280)
        }
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            
            return 15
        }
}
