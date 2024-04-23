//
//  SearchViewModel.swift
//  hh_clone
//
//  Created by Halil Yavuz on 05.04.2024.
//

import UIKit
import Combine


class SearchViewModel: ObservableObject {

    @Published var vacancies: [VacanciesModel] = []
    @Published var offers: [RecommendModel] = []
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        fetchData()
    }
    
    private func fetchData() {
        let vacanciesPublisher = DataParser.shared.fetchRecommendDataVacancies()
            .map { $0.vacancies }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
        
        let offersPublisher = DataParser.shared.fetchRecommendDataOffers()
            .map { $0.offers }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
        
        Publishers.CombineLatest(vacanciesPublisher, offersPublisher)
            .sink(receiveValue: { [weak self] vacancies, offers in
                self?.vacancies = vacancies
                self?.offers = offers
               
            })
            .store(in: &cancellables)
    }
    

    }
