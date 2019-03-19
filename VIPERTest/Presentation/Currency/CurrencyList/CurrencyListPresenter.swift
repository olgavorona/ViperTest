//
//  CurrencyListPresenter.swift
//  VIPERTest
//
//  Created by Olga Vorona on 18/03/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation

class CurrencyListPresenter: CurrencyListPresenterProtocol {

    //MARK: - Variables

    var router: CurrencyRouterProtocol!
    weak var view: CurrencyListViewProtocol!
    var interactor: CurrencyListInteractorProtocol!
    var textHelper: CurrencyTextHelperProtocol = CurrencyTextHelper()
    
    //MARK: - Init

    required init(view: CurrencyListViewProtocol) {
        self.view = view
    }
    
    //MARK: - Protocol
    
    func configureView() {
        interactor.getAllCurrencies()
    }
    
    func update(with currencies: [Currency],
                amount: String,
                USamount: Double,
                currentCurrency: Currency) {
        var viewModels = currencies.map { currency -> CurrencyListViewModel in
            let isActive = currentCurrency.ISO.rawValue == currency.ISO.rawValue
            let amount = isActive ? amount : String(format: "%.2f",USamount * currency.currencyRate)
            return CurrencyListViewModel(currency: currency,
                                         amount: amount,
                                         action: textChanged(text: newString: model:),
                                         isActive: isActive)
        }
        viewModels.sort { (first, second) -> Bool in
            if first.ISO == currentCurrency.ISO.rawValue {
                return true
            }
            if second.ISO == currentCurrency.ISO.rawValue {
                return false
            }
            return true
        }
        view.updateTableView(with: viewModels)
    }
    
    func openItem(viewModel: ViewModel) {
        router.showCurrencyRateScene(viewModel: viewModel)
    }
    
    func refreshData() {
        interactor.getAllCurrencies()
    }
    
    
    func showHUD() {
        view.showHUD()
    }
    
    func hideHUD() {
        view.hideHUD()
    }
    
    func showError(error: Error) {
        view.showError(error: error)
    }
    
    private func textChanged(text: String, newString: String, model: CurrencyListViewModel) -> (String,Bool) {
        var result = (text, false)
        if textHelper.availableAdding(text: text, string: newString) {
            result = (textHelper.addString(text: text, string: newString), false)
        }
        interactor.updateValues(currency: model.currency, amount: result.0)
        
        return result
    }
}
