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
    private let dataParser: DataParser
    let coreDataManager: CoreDataManager
    init(dataParser: DataParser, coreDataManager: CoreDataManager) {
        self.dataParser = dataParser
        self.coreDataManager = coreDataManager
        fetchData()
    }
    
    func fetchData() {
        dataParser.fetchVacancies { [weak self] result in
            switch result {
            case .success(let vacancies):
                self?.vacancies = [vacancies]
            case .failure(let error):
                print(String(describing: error))
            }
        }
        
        dataParser.fetchOffers { [weak self] result in
            switch result {
            case .success(let offers):
                self?.offers = [offers]
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    // Сохранение в избранное
    func toggleFavoriteStatus(for vacancy: VacancyModel) {
        let vacancyId = vacancy.id  // Получаем id вакансии
        
        if coreDataManager.isVacancyFavorite(id: vacancyId) {
            coreDataManager.deleteFavoriteVacancies(vacancies: vacancy)

        } else {
            coreDataManager.saveVacancies(vacancies: vacancy)
            
        }
    }
    
    // Проверка, является ли вакансия избранной
    func isFavorite(id: String) -> Bool {
        let isFavorite = coreDataManager.isVacancyFavorite(id: id)
        return isFavorite
    }
    
}
