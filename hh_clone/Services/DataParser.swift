//
//  DataParser.swift
//  hh_clone
//
//  Created by Halil Yavuz on 15.10.2024.
//

import Foundation

final class DataParser {
    
    func fetchVacancies(completion: @escaping (Result<[Vacancy], Error>) -> Void) {
        guard let jsonFilePath = Bundle.main.path(forResource: "vacancies", ofType: "json") else {
            print("Failed to locate vacancies JSON file")
            return
        }
        
        let fileURL = URL(fileURLWithPath: jsonFilePath)
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let vacancies = try decoder.decode([Vacancy].self, from: data)
            completion(.success(vacancies))
        } catch {
            completion(.failure(error))
        }
    }
    
    func fetchOffers(completion: @escaping (Result<[Offers], Error>) -> Void) {
        guard let jsonFilePath = Bundle.main.path(forResource: "offers", ofType: "json") else {
            print("Failed to locate offers JSON file")
            return
        }
        
        let fileURL = URL(fileURLWithPath: jsonFilePath)
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let offers = try decoder.decode([Offers].self, from: data)
            completion(.success(offers))
        } catch {
            completion(.failure(error))
        }
    }
}
