//
//  Vacancy.swift
//  hh_clone
//
//  Created by Halil Yavuz on 15.10.2024.
//

import Foundation

struct Vacancy: Decodable {
    let vacancies: [VacancyModel]
}

struct VacancyModel: Decodable {
    let lookingNumber: Int?
    let title: String
    let address: VacancyAddress
    let company: String
    let experience: VacancyExperience
    let publishedDate: String
    let salary: VacancySalary
    let schedules: [String]
    let appliedNumber: Int?
    let description: String?
    let responsibilities: String
    let questions: [String]
}

struct VacancyAddress: Decodable {
    let town: String
    let street: String
    let house: String
}

struct VacancyExperience: Decodable {
    let previewText: String
    let text: String
}

struct VacancySalary: Decodable {
    let full: String
}


