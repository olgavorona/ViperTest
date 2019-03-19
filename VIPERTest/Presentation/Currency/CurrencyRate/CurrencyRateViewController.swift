//
//  CurrencyRateViewController.swift
//  VIPERTest
//
//  Created by Olga Vorona on 18/03/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import UIKit

class CurrencyRateViewController: UIViewController {

    @IBOutlet var flagImage: UIImageView!
    @IBOutlet weak var USRate: UILabel!
    var viewModel: CurrencyListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flagImage.image = UIImage(named: viewModel.countryImage)
        USRate.text = viewModel.rate
    }
}
