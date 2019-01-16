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
    
}
