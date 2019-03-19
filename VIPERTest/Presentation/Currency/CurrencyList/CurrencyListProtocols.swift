//
//  CurrencyListProtocols.swift
//  VIPERTest
//
//  Created by Olga Vorona on 18/03/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation

protocol CurrencyListViewProtocol: class {
    func showHUD()
    func hideHUD()
    func updateTableView(with viewModels: [ViewModel])
    func showError(error: Error)
}

protocol CurrencyListPresenterProtocol: class {
    var router: CurrencyRouterProtocol! { set get }
    
    func configureView()
    func update(with currencies: [Currency], amount: String, USamount: Double, currentCurrency: Currency)
    func openItem(viewModel: ViewModel)
    func refreshData()
    func showHUD()
    func hideHUD()
    func showError(error: Error)
}

protocol CurrencyListInteractorProtocol: class {
    func getAllCurrencies()
    func updateValues(currency: Currency, amount: String)
}


protocol CurrencyListConfiguratorProtocol: class {
    func configure(with viewController: CurrencyListViewController)
}
