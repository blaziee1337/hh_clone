//
//  DataParser.swift
//  hh_clone
//
//  Created by Halil Yavuz on 15.10.2024.
//

import Foundation

final class DataParser {
    
    func fetchOffers() {
        guard let jsonFilePath = Bundle.main.path(forResource: "data", ofType: "json") else {
            print("Failed to locate JSON file")
            return
        }
        
        let fileURL = URL(fileURLWithPath: jsonFilePath)
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let vacancies = try decoder.decode(Offers.self, from: data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchVacancies() {
        guard let jsonFilePath = Bundle.main.path(forResource: "data", ofType: "json") else {
            print("Failed to locate JSON file")
            return
        }
        
        let fileURL = URL(fileURLWithPath: jsonFilePath)
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let vacancies = try decoder.decode(Vacancy.self, from: data)
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
}
