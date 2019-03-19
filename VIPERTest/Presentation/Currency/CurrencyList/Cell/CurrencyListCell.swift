//
//  CurrencyListCellTableViewCell.swift
//  VIPERTest
//
//  Created by Olga Vorona on 18/03/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import UIKit

class CurrencyListCell: UITableViewCell, TableCell {
    
    @IBOutlet weak var ISOLabel: UILabel!
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    weak var model: CurrencyListViewModel?
    
    func setup(with viewModel: ViewModel) {
        if let viewModel = viewModel as? CurrencyListViewModel {
            ISOLabel.text = viewModel.ISO
            currencyNameLabel.text = viewModel.currencyName
            flagImage.image = UIImage(named: viewModel.countryImage)
            textField.text = viewModel.amount
            model = viewModel
            if viewModel.isActive  {
                textField.becomeFirstResponder()
            }
        }
    }
}

extension CurrencyListCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let model = model,
            let action = model.action {
            let result = action(textField.text ?? "", string, model)
            textField.text = result.0
            return result.1
        }
        return true
    }
        
}
