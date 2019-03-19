//
//  CurrencyListViewController.swift
//  VIPERTest
//
//  Created by Olga Vorona on 18/03/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import UIKit

class CurrencyListViewController: UIViewController, CurrencyListViewProtocol {
    
    
    //MARK: - Variables

    var presenter: CurrencyListPresenterProtocol!
    var configurator: CurrencyListConfiguratorProtocol = CurrencyListConfigurator()
    var viewModels = [ViewModel]()
    
    private let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.refreshControl = refreshControl
        }
    }
    
    //MARK: - View Controller

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    @objc private func refreshData(_ sender: Any) {
        presenter.refreshData()
    }
    
    //MARK: - Protocol

    func showHUD() {
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl.beginRefreshing()
        }
    }
    
    func hideHUD() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.refreshControl.endRefreshing()
        }
    }
    
    func updateTableView(with viewModels: [ViewModel]) {
        self.viewModels = viewModels
        DispatchQueue.main.async { [weak self] in
            let range = NSMakeRange(0, self!.tableView.numberOfSections)
            let sections = NSIndexSet(indexesIn: range)
            self?.tableView.reloadSections(sections as IndexSet, with: .none)
        }
    }
    
    func showError(error: Error) {
        print(error.localizedDescription)
    }
}

extension CurrencyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModels[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.reuseIdentifier)
            as? CurrencyListCell {
            cell.setup(with: viewModel)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.openItem(viewModel: viewModels[indexPath.row])
    }
    
    
}
