//
//  ConformationTF.swift
//  hh_clone
//
//  Created by Halil Yavuz on 14.10.2024.
//

import UIKit

protocol FieldsProtocol: AnyObject {
    func textFieldDidEnterBackspace(_ textField: ConformationTF)
}

final class ConformationTF: UITextField {
    weak var fieldsDelegate: FieldsProtocol?
    
    override func deleteBackward() {
           if text?.isEmpty == true {
               fieldsDelegate?.textFieldDidEnterBackspace(self)
           }
           super.deleteBackward() 
       }
}
