//
//  VacanciesCell.swift
//  hh_clone
//
//  Created by Halil Yavuz on 18.10.2024.
//

import UIKit
import CoreData

final class VacanciesCell: UITableViewCell {
    static let identifier = "VacanciesCell"
    private var viewModel: VacanciesViewModel?
    private var currentVacancy: VacancyModel?
    private var favoriteVacancy: FavoriteVacancy?
    //MARK: - UI
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorTheme().loginInputBackground
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let lookingNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGreen
        return label
    }()
    
    private let addToFavorite: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "favouritesfalse"), for: .normal)
        return button
    }()
    
    private let vacancyNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    private let salaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let townLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    private let companyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
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
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
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
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private let respondButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = ColorTheme().findEmployeeButton
        button.layer.cornerRadius = 15
        button.setTitle("Откликнуться", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return button
    }()
    
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupUI()
        setupConstraints()
        addToFavorite.addTarget(self, action: #selector(addFavoriteTapped), for: .touchUpInside)
        contentView.isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(containerView)
        containerView.addSubview(addToFavorite)
        containerView.addSubview(lookingNumberLabel)
        containerView.addSubview(vacancyNameLabel)
        containerView.addSubview(salaryLabel)
        containerView.addSubview(townLabel)
        containerView.addSubview(companyLabel)
        containerView.addSubview(companyCheckMarkImage)
        containerView.addSubview(experinceImage)
        containerView.addSubview(experienceLabel)
        containerView.addSubview(publishedDateLabel)
        containerView.addSubview(respondButton)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            lookingNumberLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            lookingNumberLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            
            addToFavorite.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            addToFavorite.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -19),
            
            vacancyNameLabel.topAnchor.constraint(equalTo: lookingNumberLabel.bottomAnchor, constant: 10),
            vacancyNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            vacancyNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            salaryLabel.topAnchor.constraint(equalTo: vacancyNameLabel.bottomAnchor, constant: 10),
            salaryLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            
            townLabel.topAnchor.constraint(equalTo: salaryLabel.bottomAnchor, constant: 10),
            townLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            
            companyLabel.topAnchor.constraint(equalTo: townLabel.bottomAnchor, constant: 4),
            companyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            
            companyCheckMarkImage.topAnchor.constraint(equalTo: townLabel.bottomAnchor, constant: 4),
            companyCheckMarkImage.leadingAnchor.constraint(equalTo: companyLabel.trailingAnchor, constant: 10),
            
            experinceImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 17),
            experinceImage.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: 10),
            
            experienceLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: 10),
            experienceLabel.leadingAnchor.constraint(equalTo: experinceImage.trailingAnchor, constant: 8),
            
            publishedDateLabel.topAnchor.constraint(equalTo: experienceLabel.bottomAnchor, constant: 10),
            publishedDateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            
            respondButton.topAnchor.constraint(equalTo: publishedDateLabel.bottomAnchor, constant: 10),
            respondButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            respondButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            respondButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
        
    }
    
    func configure(cell: VacancyModel, viewModel: VacanciesViewModel) {
        
        self.currentVacancy = cell
        self.viewModel = viewModel
        
        guard let number = cell.lookingNumber else {
            lookingNumberLabel.isHidden = false
            return
        }
        switch number {
        case 2, 3, 4:
            lookingNumberLabel.text = "Сейчас просматривает \(number) человека"
        default:
            lookingNumberLabel.text = "Сейчас просматривает \(number) человек"
        }
        
        vacancyNameLabel.text = cell.title
        salaryLabel.text = cell.salary.short
        townLabel.text = cell.address.town
        companyLabel.text = cell.company
        experienceLabel.text = cell.experience.previewText
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "d MMMM"
        outputFormatter.locale = Locale(identifier: "ru_RU")
        let date = inputFormatter.date(from: cell.publishedDate )
        let formattedDate = outputFormatter.string(from: date ?? Date())
        
        if cell.publishedDate != "" {
            publishedDateLabel.text = "Опубликовано \(formattedDate)"
            
        } else {
            publishedDateLabel.text = cell.publishedDate
        }
        
        updateFavoriteButtonImage()
    }
    func configureFavorite(cell: FavoriteVacancy, viewModel: VacanciesViewModel) {
        self.viewModel = viewModel
        self.favoriteVacancy = cell
        let number = cell.lookingNumber
        switch number {
        case 2, 3, 4:
            lookingNumberLabel.text = "Сейчас просматривает \(number) человека"
        default:
            lookingNumberLabel.text = "Сейчас просматривает \(number) человек"
        }
        
        vacancyNameLabel.text = cell.vacancyName
        salaryLabel.text = cell.vacancySalary
        townLabel.text = cell.vacancyCity
        companyLabel.text = cell.vacancyCompany
        experienceLabel.text = cell.vacancyExperience
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "d MMMM"
        outputFormatter.locale = Locale(identifier: "ru_RU")
        let date = inputFormatter.date(from: cell.vacancyPublishedDate ?? "")
        let formattedDate = outputFormatter.string(from: date ?? Date())
        
        if cell.vacancyPublishedDate != "" {
            publishedDateLabel.text = "Опубликовано \(formattedDate)"
            
        } else {
            publishedDateLabel.text = cell.vacancyPublishedDate
        }
        
        updateFavoriteButtonImage()
    }
    
    private func updateFavoriteButtonImage() {
        if let vacancyId = currentVacancy?.id ?? favoriteVacancy?.id, viewModel?.isFavorite(id: vacancyId) == true {
            addToFavorite.setImage(UIImage(named: "favouritetrue"), for: .normal)
        } else {
            addToFavorite.setImage(UIImage(named: "favouritesfalse"), for: .normal)
        }
    }
    
    @objc private func addFavoriteTapped() {
        guard let vacancy = currentVacancy else { return }
        
        viewModel?.toggleFavoriteStatus(for: vacancy)
        
        let isFavoriteNow = viewModel?.isFavorite(id: vacancy.id) ?? false
        let newImageName = isFavoriteNow ? "favouritetrue" : "favouritesfalse"
        addToFavorite.setImage(UIImage(named: newImageName), for: .normal)
    }
}
