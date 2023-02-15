//
//  StringExtension.swift
//  CarGo
//
//  Created by Andrei Mirica on 19.12.2022.
//

import Foundation

extension String {

    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isValidPhoneNumber() -> Bool {
        let pattern = #"^(0|\+40)?(2\d{8}|3[0-9]\d{7}|7[0-9]\d{7})$"# // your regex pattern
           let regex = try? NSRegularExpression(pattern: pattern)
        
        guard let regex = regex else {
            return false
        }
        
           let range = NSRange(location: 0, length: self.utf16.count)
           return regex.firstMatch(in: self, options: [], range: range) != nil
       }
    }
