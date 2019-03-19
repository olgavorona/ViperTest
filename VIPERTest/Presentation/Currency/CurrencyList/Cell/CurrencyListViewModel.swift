//
//  CurrencyListViewModel.swift
//  VIPERTest
//
//  Created by Olga Vorona on 18/03/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation

typealias ActionHandler = (String, String, CurrencyListViewModel) -> (String, Bool)

class CurrencyListViewModel: ViewModel {
    var reuseIdentifier = "CurrencyListCell"
   
    let ISO: String
    let currencyName: String
    let countryImage: String
    let rate: String
    var amount: String
    
    var action: ActionHandler?
    var isActive: Bool = false
    let currency: Currency
    
    init(currency: Currency,
         amount: String,
         action: ActionHandler? = nil,
         isActive: Bool = false) {
        ISO = currency.ISO.rawValue
        currencyName = currency.currancyName
        countryImage = currency.countryImage
        rate = String(currency.currencyRate)
        self.amount = amount
        self.action = action
        self.currency = currency
        self.isActive = isActive
    }
    
}
