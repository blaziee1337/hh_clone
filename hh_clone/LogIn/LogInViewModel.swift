//
//  LogInViewModel.swift
//  hh_clone
//
//  Created by Halil Yavuz on 03.04.2024.
//

import Foundation
import Combine


class LogInViewModel {
    
    weak var appCoordinator: LogInCoordinator!
    var emailPublisher = PassthroughSubject<String, Never>()
    @Published var email: String = ""
    var emailValidationPublisher = PassthroughSubject<Bool, Never>()
    var continueButtonTapped = PassthroughSubject<Void, Never>()
    var isValidEmail: AnyPublisher<Bool, Never> {
        $email.map { $0.isEmail() }
            .eraseToAnyPublisher()
        }
    
    func goToConfirm() {
        appCoordinator.goToConfirm()
       
    }
    
    
}


extension String {
    
    struct EmailValidation {
        private static let firstpart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
        private static let serverpart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
        private static let emailRegex = firstpart + "@" + serverpart + "[A-Za-z]{2,8}"
        static let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    }
    
    func isEmail() -> Bool {
        return EmailValidation.emailPredicate.evaluate(with: self)
        
    }
}
