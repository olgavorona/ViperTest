//
//  CurrencyListInteractor.swift
//  VIPERTest
//
//  Created by Olga Vorona on 18/03/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation

class CurrencyListInteractor: CurrencyListInteractorProtocol {
    
    //MARK: - variables

    weak var presenter: CurrencyListPresenterProtocol!
    let currencyService: CurrencyServiceProtocol = CurrencyService()
    
    private var USamount: Double = 1
    private var amount: String = "1"
    private var baseCurrency: Currency
    private var currentCurrency: Currency

    private var currencies = [Currency]()
    private var editSumBlock: DispatchHelper.CancelableBlock?
    
    //MARK: - init
    required init(presenter: CurrencyListPresenterProtocol) {
        self.presenter = presenter
        baseCurrency = Currency(currencyRate: 1,
                                   ISO: .USD)
        currentCurrency = baseCurrency
    }
    
    //MARK: - protocol

    func getAllCurrencies() {
        presenter.showHUD()
        currencyService.getCurrencies(with: baseCurrency, ISOs: CurrenciesISO.allCases) {[weak self] (currencies, error) in
            guard let self = self else { return }
            self.presenter.hideHUD()
            if let error = error {
                self.presenter.showError(error: error)
            } else if let currencies = currencies {
                self.currencies = currencies
                self.presenter.update(with: currencies,
                                      amount: self.amount,
                                      USamount: self.USamount,
                                      currentCurrency: self.currentCurrency)
            }
        }
    }
    
    func updateValues(currency: Currency, amount: String) {
        currentCurrency = currency
        self.amount = amount
        self.USamount = (Double(amount) ?? 0) / currency.currencyRate

        //задержка для ввода текста
        DispatchHelper.dispatchCancelBlock(editSumBlock)
        editSumBlock = DispatchHelper.dispathAfterDelay(1.0, dispatchBlock: { [weak self] in
            guard let `self` = self else { return }
            self.presenter.update(with: self.currencies,
                                  amount: self.amount,
                                  USamount: self.USamount,
                                  currentCurrency: self.currentCurrency)
        })
    }
    
    
}
