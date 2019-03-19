//
//  CurrencyTextHelper.swift
//  VIPERTest
//
//  Created by Olga Vorona on 19/03/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation

protocol CurrencyTextHelperProtocol {
    func availableAdding(text: String, string: String) -> Bool
    func addString(text: String, string: String) -> String
}

class CurrencyTextHelper: CurrencyTextHelperProtocol {
    let maxlength = 8
    
    func availableAdding(text: String, string: String) -> Bool {
        if text.count == maxlength && string.count > 0 {
            return false
        }
        switch string {
        case "":
            return text != ""
        case "0"..."9":
            return text != "0"
        case ".", ",":
            return text.count > 0 && text.range(of: ".") == nil && text.range(of: ",") == nil
        default:
            return false
        }
    }
    
    func addString(text: String, string: String) -> String {
        var newValue: String = text
        var addingString = string
        if addingString == "", newValue.count > 0 {
            newValue.removeLast()
        } else if addingString != "" {
            if addingString == "," {
                addingString = "."
            }
            newValue.append(addingString)
        }
        return newValue
    }
}
