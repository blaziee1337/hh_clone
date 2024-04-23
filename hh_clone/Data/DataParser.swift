//
//  DataParser.swift
//  hh_clone
//
//  Created by Halil Yavuz on 03.04.2024.
//

import Foundation
import Combine

class DataParser {
    
    static let shared = DataParser()
    
    private let jsonFilePath = Bundle.main.path(forResource: "data", ofType: "json")
    
    func fetchRecommendDataOffers() -> AnyPublisher<Offers, Error> {
        guard let filePath = Bundle.main.path(forResource: "json", ofType: "json") else {
            fatalError("Failed to locate JSON file")
        }
        
        let fileURL = URL(fileURLWithPath: filePath)
        do {
            let data = try Data(contentsOf: fileURL)
            return Just(data)
                .tryMap { data in
                    try JSONDecoder().decode(Offers.self, from: data)
                }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    func fetchRecommendDataVacancies() -> AnyPublisher<Vacancies, Error> {
        guard let filePath = Bundle.main.path(forResource: "json", ofType: "json") else {
            fatalError("Failed to locate JSON file")
        }
        
        let fileURL = URL(fileURLWithPath: filePath)
        do {
            let data = try Data(contentsOf: fileURL)
            return Just(data)
                .tryMap { data in
                    try JSONDecoder().decode(Vacancies.self, from: data)
                }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
