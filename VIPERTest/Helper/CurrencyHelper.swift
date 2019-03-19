//
//  CurrencyHelper.swift
//  VIPERTest
//
//  Created by Olga Vorona on 18/03/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation

protocol CurrencyHelperProtocol {
    static func countryName(for ISO: CurrenciesISO) -> String
    static func imageName(for ISO: CurrenciesISO) -> String
}

class CurrencyHelper: CurrencyHelperProtocol {
    
    static func countryName(for ISO: CurrenciesISO) -> String {
        var result = ""
        switch ISO {
        case .EUR:
            result = "Euro"
        case .USD:
            result = "US Dollar"
        case .RUB:
            result = "Russian Ruble"
        case .JPY:
            result = "Japanese Yen"
        case .HKD:
            result = "Hong Kong Dollar"
        }
        return result
    }
    
    static func imageName(for ISO: CurrenciesISO) -> String {
        return ISO.rawValue
    }
    
    
}
