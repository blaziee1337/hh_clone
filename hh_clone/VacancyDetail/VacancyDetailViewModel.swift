//
//  VacancyViewModel.swift
//  hh_clone
//
//  Created by Halil Yavuz on 06.04.2024.
//

import Foundation

struct VacancyDetailViewModel {
    let title: String
    let company: String
    let salary: String
    let experience: String
    let schedules: [String]
    let lookingNumber: Int?
    let appliedNumber: Int?
    let town: String
    let street: String
    let house: String
    let description: String?
    let responsibilities: String
    let questions: [String]
    
    init(vacancyViewModel: VacanciesModel) {
        self.title = vacancyViewModel.title
        self.company = vacancyViewModel.company
        self.salary = vacancyViewModel.salary.full
        self.experience = vacancyViewModel.experience.previewText
        self.schedules = vacancyViewModel.schedules
        self.lookingNumber = vacancyViewModel.lookingNumber
        self.appliedNumber = vacancyViewModel.appliedNumber
        self.town = vacancyViewModel.address.town
        self.street = vacancyViewModel.address.street
        self.house = vacancyViewModel.address.house
        self.description = vacancyViewModel.description
        self.responsibilities = vacancyViewModel.responsibilities
        self.questions = vacancyViewModel.questions
}


    
}
