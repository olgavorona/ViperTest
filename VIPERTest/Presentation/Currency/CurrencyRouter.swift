//
//  CurrencyListRouter.swift
//  VIPERTest
//
//  Created by Olga Vorona on 18/03/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import UIKit


protocol CurrencyRouterProtocol: class {
    func showCurrencyRateScene(viewModel: ViewModel)
}

class CurrencyRouter: CurrencyRouterProtocol {
    func showCurrencyRateScene(viewModel: ViewModel) {
        guard let vm = viewModel as? CurrencyListViewModel,
        let vc = storyboard.instantiateViewController(withIdentifier: "CurrencyRateViewController") as? CurrencyRateViewController
            else { return }
        
        vc.viewModel = vm
        viewController.show(vc, sender: nil)
    }
    
    let storyboard = UIStoryboard.init(name: "Currency", bundle: nil)

    weak var viewController: UIViewController!
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}
