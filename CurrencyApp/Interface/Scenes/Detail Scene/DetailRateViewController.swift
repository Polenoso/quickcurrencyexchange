//
//  DetailRateViewController.swift
//  CurrencyApp
//
//  Created by Aitor Pagán on 18/01/2019.
//  Copyright © 2019 polenoso. All rights reserved.
//

import UIKit

class DetailRateViewController: UIViewController {

    @IBOutlet var rateDateLabel: UILabel!
    @IBOutlet var ratePricesTableView: UITableView!
    
    var dataSource: [DetailRateModels.DisplayedValue] = []
    
    var input: DetailRateInputProtocol?
    var router: (DetailRateNavigationProtocol & DetailRateDataPassing)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let presenter = DetailRatePresenter(output: self)
        input = presenter
        let navigator = DetailRateRouter()
        navigator.viewController = self
        navigator.dataStore = presenter
        router = navigator
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        input?.getDetail(request: DetailRateModels.GetDetail.Request())
    }
    
    private func setupTableView() {
        ratePricesTableView.dataSource = self
        ratePricesTableView.register(UINib.init(nibName: "DetailRateValueTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: DetailRateValueTableViewCell.reusableIdentifier)
        ratePricesTableView.estimatedRowHeight = 2.0
        ratePricesTableView.rowHeight = UITableView.automaticDimension
    }

}

extension DetailRateViewController: DetailRateOutputProtocol {
    
    func displayDetail(viewModel: DetailRateModels.GetDetail.ViewModel) {
        rateDateLabel.text = viewModel.title
        dataSource = viewModel.values
        ratePricesTableView.reloadData()
    }
    
    func displayValue(viewModel: DetailRateModels.SingleValue.ViewModel) {
        dataSource.append(viewModel.value)
        ratePricesTableView.beginUpdates()
        ratePricesTableView.insertRows(at: [IndexPath(row: dataSource.count - 1, section: 0)], with: .bottom)
        ratePricesTableView.endUpdates()
    }
    
    func displayLoading(viewModel: DetailRateModels.Loading.Show.ViewModel) {
        let loadingView = UIActivityIndicatorView(style: .gray)
        ratePricesTableView.tableFooterView = loadingView
        loadingView.startAnimating()
    }
    
    func hideLoading(viewModel: DetailRateModels.Loading.Hide.ViewModel) {
        ratePricesTableView.tableFooterView = UIView()
    }
    
}

extension DetailRateViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailRateValueTableViewCell.reusableIdentifier, for: indexPath) as! DetailRateValueTableViewCell
        
        cell.updateUI(data: dataSource[indexPath.row])
        
        return cell
    }
    
}
