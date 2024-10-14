//
//  ConformationViewModel.swift
//  hh_clone
//
//  Created by Halil Yavuz on 27.09.2024.
//


import Foundation

final class ConformationViewModel {
    var email: String = ""
    private var verificationCode = Array(repeating: "", count: 4)

    // Функция для проверки, что код полностью введен
    func isCodeComplete() -> Bool {
        return verificationCode.allSatisfy { !$0.isEmpty }
    }

    // Функция для обновления кода на конкретном индексе
    func updateCode(at index: Int, with value: String) {
        guard index < verificationCode.count else { return }
        verificationCode[index] = value
        
    }

    // Функция для удаления значения на конкретном индексе
    func removeCode(at index: Int) {
        guard index < verificationCode.count else { return }
        verificationCode[index] = ""
        
    }
}
