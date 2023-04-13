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
    
    func isValidNumberPlate() -> Bool {
        let numberPlateArray = self.split(separator: " ")
        
        if numberPlateArray.count != 3 {
            return false
        }
        
        if RomanianCounty(rawValue: String(numberPlateArray[0])) == nil {
            return false
        }
        
        var regex = "^\\d{2,3}$"
        var predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isMatchingNumber = predicate.evaluate(with: String(numberPlateArray[1]))
        
        regex = "^[a-zA-Z]{3}$"
        predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isMatching = predicate.evaluate(with: numberPlateArray[2])
        
        return (isMatching && isMatchingNumber)
    }
    
    func toDate() -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.date(from: self)
    }
    
    func localTimezoneDateString() -> String {
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from: self)
        return date?.changeToLocalTimezone() ?? ""
    }
}
