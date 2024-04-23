//
//  VacancyCellViewModel.swift
//  hh_clone
//
//  Created by Halil Yavuz on 05.04.2024.
//

import Foundation

struct VacancyCellViewModel {
    let lookingNumber: Int?
    let title: String
    let town: String
    let company: String
    let experience: String
    let publishedDate: String
    
    init(viewModel: VacanciesModel) {
        self.lookingNumber = viewModel.lookingNumber
        self.title = viewModel.title
        self.town = viewModel.address.town
        self.company = viewModel.company
        self.experience = viewModel.experience.previewText
        self.publishedDate = viewModel.publishedDate
    }
}
