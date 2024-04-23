//
//  VacanciesCell.swift
//  hh_clone
//
//  Created by Halil Yavuz on 05.04.2024.
//

import UIKit
import CoreData


final class VacanciesViewCell: UICollectionViewCell {
    
   static let identifier = "VacanciesViewCell"
    
   private let context: NSManagedObjectContext = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
    
   private let fetchRequest: NSFetchRequest = FavouriteVacancy.fetchRequest()
    
    private var viewmodel = SearchViewModel()
 
    private var isFavourite: Bool = false
    
    
    //MARK: - UI
    
    private let lookingNumberLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 76/255, green: 178/255, blue: 78/255, alpha: 1)
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let addToFavorites: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "favouritesfalse"), for: .normal)
        return button
    }()
    
    private let vacancyNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let townLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let companyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let companyCheckMarkImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "checkMark")
        return imageView
    }()

    private let experienceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let experinceImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "experience")
        return imageView
        
    }()
    
    private let publishedDateLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 76/255, green: 178/255, blue: 78/255, alpha: 1)
        button.layer.cornerRadius = 15
        button.setTitle("Откликнуться", for: .normal)
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()

    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        constraints()
        layer.cornerRadius = 15
        addToFavorites.addTarget(self, action: #selector(addFavouriteButton), for: .touchUpInside)

          }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubview(addToFavorites)
        addSubview(lookingNumberLabel)
        addSubview(vacancyNameLabel)
        addSubview(townLabel)
        addSubview(companyLabel)
        addSubview(companyCheckMarkImage)
        addSubview(experinceImage)
        addSubview(experienceLabel)
        addSubview(publishedDateLabel)
        addSubview(shareButton)
                
    }
    
    
    @objc func addFavouriteButton()  {
       
        if !isFavourite {
            addToFavorites.setImage(UIImage(named: "favouritetrue"), for: .normal)
            isFavourite = true

            guard let model = viewmodel.vacancies.first else { return }
            let cellViewModel = VacancyCellViewModel(viewModel: model)
            checkFavourite(cellViewModel: cellViewModel)

        } else {
            addToFavorites.setImage(UIImage(named: "favouritesfalse"), for: .normal)
            isFavourite = false


            guard let model = viewmodel.vacancies.first else { return }
            let cellViewModel = VacancyCellViewModel(viewModel: model)
            checkFavourite(cellViewModel: cellViewModel)
                do {
                   
                    try deleteFavouriteVacancy1(for: cellViewModel)

                } catch {
                    print("Error deleting track from dataBase: \(error.localizedDescription)")

            }
        
        }
    }
    
    //MARK: - Constraints
    
   private func constraints() {
        
        NSLayoutConstraint.activate([
            lookingNumberLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            lookingNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            addToFavorites.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            addToFavorites.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            vacancyNameLabel.topAnchor.constraint(equalTo: lookingNumberLabel.bottomAnchor, constant: 10),
            vacancyNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            vacancyNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            townLabel.topAnchor.constraint(equalTo: vacancyNameLabel.bottomAnchor, constant: 15),
            townLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            companyLabel.topAnchor.constraint(equalTo: townLabel.bottomAnchor, constant: 10),
            companyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            companyCheckMarkImage.centerYAnchor.constraint(equalTo: companyLabel.centerYAnchor),
            companyCheckMarkImage.leadingAnchor.constraint(equalTo: companyLabel.trailingAnchor, constant: 8),
            
            experinceImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            experinceImage.centerYAnchor.constraint(equalTo: experienceLabel.centerYAnchor),
            
            experienceLabel.leadingAnchor.constraint(equalTo: experinceImage.trailingAnchor, constant: 8),
            experienceLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: 10),
            
            publishedDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            publishedDateLabel.topAnchor.constraint(equalTo: experienceLabel.bottomAnchor, constant: 20),
            
            shareButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            shareButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            shareButton.topAnchor.constraint(equalTo: publishedDateLabel.bottomAnchor, constant: 25),
            shareButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -9)
           

                    
                    
])
    }
    
    //MARK: - Configure
    
    func configure(cellViewModel: VacancyCellViewModel) {
        
        guard let number = cellViewModel.lookingNumber else {
            lookingNumberLabel.isHidden = false
            return
        }
        switch number {
        case 2, 3, 4:
            lookingNumberLabel.text = "Сейчас просматривает \(number) человека"
        default:
            lookingNumberLabel.text = "Сейчас просматривает \(number) человек"
        }
        vacancyNameLabel.text = cellViewModel.title
        vacancyNameLabel.textColor = .white
        townLabel.text = cellViewModel.town
        companyLabel.text = cellViewModel.company
        experienceLabel.text = cellViewModel.experience
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "d MMMM"
        outputFormatter.locale = Locale(identifier: "ru_RU")
        let date = inputFormatter.date(from: cellViewModel.publishedDate )
        let formattedDate = outputFormatter.string(from: date ?? Date())
        
        if cellViewModel.publishedDate != "" {
            publishedDateLabel.text = "Опубликовано \(formattedDate)"

        } else {
            publishedDateLabel.text = cellViewModel.publishedDate
        }

    }


    func configureFavourite(cellViewModel: FavouriteVacancy) {
        
        addToFavorites.setImage(UIImage(named: "favouritetrue"), for: .normal)
         let number = cellViewModel.lookingNumber
                   
        switch number {
        case 2, 3, 4:
            lookingNumberLabel.text = "Сейчас просматривает \(number) человека"
        default:
            lookingNumberLabel.text = "Сейчас просматривает \(number) человек"
        }

      
        vacancyNameLabel.text = cellViewModel.vacancyName
        vacancyNameLabel.textColor = .white
        townLabel.text = cellViewModel.vacancyCity
        companyLabel.text = cellViewModel.vacancyCompany
        experienceLabel.text = cellViewModel.vacancyExperience
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "d MMMM"
        outputFormatter.locale = Locale(identifier: "ru_RU")
        let date = inputFormatter.date(from: cellViewModel.vacancyDate ?? "")
        let formattedDate = outputFormatter.string(from: date ?? Date())
        
        if cellViewModel.vacancyDate != "" {
            publishedDateLabel.text = "Опубликовано \(formattedDate)"
            
        } else {
            publishedDateLabel.text = cellViewModel.vacancyDate
        }
    }
    
    
    //MARK: - CoreData
    
    
    private func checkFavourite(cellViewModel: VacancyCellViewModel) {

        do {
            let count = try context.count(for: fetchRequest)

            if count == 0 {

                createFavouriteVacancy(from: cellViewModel)
            } else {

                try deleteFavouriteVacancy1(for: cellViewModel)

            }
        } catch {
            print("Could not fetch or delete. \(error)")
        }



    }

    private func createFavouriteVacancy(from cellViewModel: VacancyCellViewModel) {
        let favouriteVacancy = FavouriteVacancy(context: context)
        configureFavouriteVacancy(favouriteVacancy, with: cellViewModel)

        do {
            try context.save()
        } catch {
            print("Failed to save favourite vacancy: \(error)")
            context.rollback()
        }
    }

    private func deleteFavouriteVacancy1(for cellViewModel: VacancyCellViewModel) throws {

        let objects = try context.fetch(fetchRequest)
        for object in objects {
            context.delete(object)
        }
        try context.save()
    }

    private func configureFavouriteVacancy(_ favouriteVacancy: FavouriteVacancy, with cellViewModel: VacancyCellViewModel) {
        if let lookingNumber = cellViewModel.lookingNumber {
            favouriteVacancy.lookingNumber = Int32(lookingNumber)
        }
        favouriteVacancy.vacancyName = cellViewModel.title
        favouriteVacancy.vacancyCity = cellViewModel.town
        favouriteVacancy.vacancyCompany = cellViewModel.company
        favouriteVacancy.vacancyExperience = cellViewModel.experience
        favouriteVacancy.vacancyDate = cellViewModel.publishedDate
        if context.hasChanges {
            do {
                context.insert(favouriteVacancy)
                try context.save()
            } catch {
                context.rollback()
                print("Error")
            }
        }
    }
}
