//
//  Currency.swift
//  VIPERTest
//
//  Created by Olga Vorona on 18/03/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation

enum CurrenciesISO: String, CaseIterable {
    case USD
    case EUR
    case RUB
    case HKD
    case JPY
}

struct Currency {
    let currencyRate: Double
    let ISO: CurrenciesISO
    let currancyName: String
    let countryImage: String
    
    init(currencyRate: Double,
         ISO: CurrenciesISO) {
        self.currencyRate = currencyRate
        self.ISO = ISO
        self.currancyName = CurrencyHelper.countryName(for: ISO)
        self.countryImage = CurrencyHelper.imageName(for: ISO)
    }
}
