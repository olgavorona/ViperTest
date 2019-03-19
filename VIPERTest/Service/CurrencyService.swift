//
//  CurrencyService.swift
//  VIPERTest
//
//  Created by Olga Vorona on 18/03/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation

protocol CurrencyServiceProtocol {
    func getCurrencies(with currency: Currency, ISOs: [CurrenciesISO], completion: @escaping CurrencyClosure)
    func updateCurrencies(with currency: Currency, amount: Double, completion: ([Currency]))
}

typealias CurrencyClosure = ([Currency]?, Error?) -> Void

struct CurrencyError : Error {
    let description : String
    var localizedDesc: String {
        return NSLocalizedString(description, comment: "")
    }
}

class CurrencyService: Service, CurrencyServiceProtocol {
    
    enum parameterKeys: String {
        case rates
    }
    
    override var baseURL: String {
        return "https://revolut.duckdns.org/latest?base=USD"
    }
    
    func getCurrencies(with currency: Currency,
                       ISOs: [CurrenciesISO],
                       completion: @escaping CurrencyClosure)  {
        getJSON(URL: URL(string: baseURL)!) { (json, error) in
            if let error = error {
                completion(nil, error)
                return
            } else if let json = json,
                let rates = json[parameterKeys.rates.rawValue] as? [String: Double] {
                var currencies = [Currency]()
                currencies.append(currency)
                for ISO in ISOs {
                    if let rate = rates[ISO.rawValue] {
                        let currency = Currency(currencyRate: rate,
                                                ISO: ISO)
                        currencies.append(currency)
                    }
                }
                completion(currencies, nil)
            }
            else {
                completion(nil, CurrencyError(description: "Ошибка данных"))
            }
        }
    }
    
    func updateCurrencies(with currency: Currency,
                          amount: Double,
                          completion: ([Currency])) {
        
    }
}
