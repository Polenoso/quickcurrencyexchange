//
//  DetailRatePresenter.swift
//  CurrencyApp
//
//  Created by Aitor Pagán on 18/01/2019.
//  Copyright © 2019 polenoso. All rights reserved.
//

import Foundation

protocol DetailRateOutputProtocol: class {
    func displayDetail(viewModel: DetailRateModels.GetDetail.ViewModel)
    func displayValue(viewModel: DetailRateModels.SingleValue.ViewModel)
    func displayLoading(viewModel: DetailRateModels.Loading.Show.ViewModel)
    func hideLoading(viewModel: DetailRateModels.Loading.Hide.ViewModel)
}

protocol DetailRateInputProtocol {
    func getDetail(request: DetailRateModels.GetDetail.Request)
}

protocol DetailRateDataStore {
    var currencyDto: CurrencyDto? { get set }
}

final class DetailRatePresenter: DetailRateInputProtocol, DetailRateDataStore {
    
    var currencyDto: CurrencyDto?
    
    private var output: DetailRateOutputProtocol
    
    private var worker: DetailRateWorkerProtocol
    
    private var numberOfValues = 0
    
    init(worker: DetailRateWorkerProtocol = DetailRateWorker(),output: DetailRateOutputProtocol) {
        self.output = output
        self.worker = worker
    }
    
    func getDetail(request: DetailRateModels.GetDetail.Request) {
        guard let currencyDto = currencyDto else { return }
        output.displayLoading(viewModel: DetailRateModels.Loading.Show.ViewModel())
        
        //TODO: Request rates till all currency types are set
        let viewModel = DetailRateModels.GetDetail.ViewModel.init(title: "BitCoin value at: \(currencyDto.date.toString(with: .displayed))", values: currencyDto.values.map({DetailRateModels.DisplayedValue(value:"\($0.value)", symbol:$0.type.rawValue)}))
        output.displayDetail(viewModel: viewModel)
        DispatchQueue.main.async {
            self.numberOfValues = currencyDto.values.count
            if (self.numberOfValues < CurrencyType.allCases.count) {
                let remainingCurrencies:[CurrencyType] = CurrencyType.allCases.filter({ (type) -> Bool in
                    return !currencyDto.values.contains(where: {$0.type == type})
                })
                remainingCurrencies.forEach { (type) in
                    self.worker.fetchRates(for: type, from: currencyDto.date, to: currencyDto.date, completionBlock: { (mbpi, error) in
                        self.numberOfValues += 1
                        if (error == nil) {
                            self.presentSingleValue(mbpi!.bpis.first!, type: type)
                        }
                        self.didEndLoading()
                    })
                }
            }
        }
    }
    
    private func presentSingleValue(_ currency: SimpleCurrency, type: CurrencyType) {
        let viewModel = DetailRateModels.SingleValue.ViewModel.init(value: DetailRateModels.DisplayedValue(value: "\(currency.rate)", symbol:type.rawValue))
        output.displayValue(viewModel: viewModel)
    }
    
    private func didEndLoading() {
        if(numberOfValues == CurrencyType.allCases.count) {
            output.hideLoading(viewModel: DetailRateModels.Loading.Hide.ViewModel())
        }
    }
}
