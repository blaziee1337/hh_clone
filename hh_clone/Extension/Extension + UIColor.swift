//
//  Extension + UIColor.swift
//  hh_clone
//
//  Created by Halil Yavuz on 27.09.2024.
//

import UIKit

extension UIColor {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let loginInputBackground = UIColor(named: "loginInputView")
    let loginInputTF = UIColor(named: "loginInputTF")
    let continueButton = UIColor(named: "continueButton")
    let findEmployeeButton = UIColor(named: "findEmployeeButton")
    let numberOfVacancyViewedBackground = UIColor(named: "numberOfVacancy")
}
