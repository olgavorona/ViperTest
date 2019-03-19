//
//  CurrencyListComposer.swift
//  VIPERTest
//
//  Created by Olga Vorona on 18/03/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation

class CurrencyListConfigurator: CurrencyListConfiguratorProtocol {
    
    func configure(with viewController: CurrencyListViewController) {
        let presenter = CurrencyListPresenter(view: viewController)
        let interactor = CurrencyListInteractor(presenter: presenter)
        let router = CurrencyRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
