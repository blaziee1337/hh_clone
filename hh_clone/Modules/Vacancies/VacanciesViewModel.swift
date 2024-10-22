//
//  VacanciesViewModel.swift
//  hh_clone
//
//  Created by Halil Yavuz on 15.10.2024.
//

import Foundation

final class VacanciesViewModel {
    
    var vacancies: [Vacancy] = []
    var offers: [Offers] = []
    var onDataUpdated: (() -> Void)?
    private let dataParser: DataParser
    
    init(dataParser: DataParser) {
        self.dataParser = dataParser
        fetchData()
    }
    
    func fetchData() {
        dataParser.fetchVacancies { [weak self] result in
            switch result {
            case .success(let vacancies):
                self?.vacancies = [vacancies]
                self?.onDataUpdated?()
            case .failure(let error):
                print(String(describing: error))
            }
        }
        
        dataParser.fetchOffers { [weak self] result in
            switch result {
            case .success(let offers):
                self?.offers = [offers]
                self?.onDataUpdated?()
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}
