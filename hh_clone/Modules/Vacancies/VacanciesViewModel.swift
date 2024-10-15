//
//  VacanciesViewModel.swift
//  hh_clone
//
//  Created by Halil Yavuz on 15.10.2024.
//

import Foundation

final class VacanciesViewModel {
    
    private var vacancies: [Vacancy] = []
    private var offers: [Offers] = []
    
    private let dataParser: DataParser
    
    init(dataParser: DataParser) {
        self.dataParser = dataParser
    }
    
    func fetchData() {
            dataParser.fetchVacancies { [weak self] result in
                switch result {
                case .success(let vacancies):
                    self?.vacancies = vacancies
                case .failure(let error):
                    print("Error fetching vacancies: \(error.localizedDescription)")
                }
            }
            
            dataParser.fetchOffers { [weak self] result in
                switch result {
                case .success(let offers):
                    self?.offers = offers
                case .failure(let error):
                    print("Error fetching offers: \(error.localizedDescription)")
                }
            }
        }
    }
