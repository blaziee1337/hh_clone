//
//  LogInViewModel.swift
//  hh_clone
//
//  Created by Halil Yavuz on 27.09.2024.
//

import Foundation

final class LogInViewModel {
    var email: String = ""
    var errorMessage: String?
    
    func validateEmail() -> Bool {
        // Простая валидация email через регулярное выражение
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let isValid = emailPredicate.evaluate(with: email)
        
        if !isValid {
            errorMessage = "Неверный формат email"
        } else {
            errorMessage = nil
        }
        
        return isValid
    }
}
