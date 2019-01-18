//
//  MainViewController.swift
//  CurrencyApp
//
//  Created by Aitor Pagán on 16/1/19.
//  Copyright © 2019 polenoso. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var input: MainSceneInputProtocol?
    var router: (MainSceneNavigationProtocol & MainSceneDataPassing)?

    var dataSource: [MainModels.GetRates.Displayed] = []
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {        
        let presenter = MainPresenter(output: self)
        input = presenter
        let navigator = MainRouter()
        navigator.viewController = self
        navigator.dataStore = presenter
        router = navigator
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib.init(nibName: "MainDisplayedRateTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: MainDisplayedRateTableViewCell.reusableIdentifier)
        tableView.estimatedRowHeight = 2.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }
    
    private func loadData() {
        input?.getRates(request: MainModels.GetRates.Request())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadData()
    }

}

extension MainViewController: MainSceneOutputProtocol {
    
    func displayRates(viewModel: MainModels.GetRates.ViewModel) {
        dataSource = viewModel.data
        tableView.reloadData()
    }
    
    func displayError(viewModel: MainModels.Error.ViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    func displaySelectRate(viewModel: MainModels.SelectRate.ViewModel) {
        router?.navigateToDetail()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainDisplayedRateTableViewCell.reusableIdentifier, for: indexPath) as! MainDisplayedRateTableViewCell
        
        cell.updateUI(viewModel: dataSource[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let request = MainModels.SelectRate.Request.init(index: indexPath.row)
        input?.selectRate(request: request)
    }
    
}
