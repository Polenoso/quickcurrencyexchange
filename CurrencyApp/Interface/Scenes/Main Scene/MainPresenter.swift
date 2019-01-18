//
//  MainPresenter.swift
//  CurrencyApp
//
//  Created by Aitor Pagán on 16/1/19.
//  Copyright © 2019 polenoso. All rights reserved.
//

import Foundation

protocol MainSceneOutputProtocol: class {
    func displayRates(viewModel: MainModels.GetRates.ViewModel)
    func displayError(viewModel: MainModels.Error.ViewModel)
    func displaySelectRate(viewModel: MainModels.SelectRate.ViewModel)
}

protocol MainSceneInputProtocol {
    func getRates(request: MainModels.GetRates.Request)
    func selectRate(request: MainModels.SelectRate.Request)
}

protocol MainSceneDataStore {
    var selectedBpi: CurrencyDto? { get }
}

final class MainPresenter: MainSceneInputProtocol, MainSceneDataStore {
    
    var selectedBpi: CurrencyDto?
    
    private var worker: MainSceneWorkerProtocol
    
    var output: MainSceneOutputProtocol?
    
    private var cachedBpi: MultipleBPI?
    
    init(worker: MainSceneWorkerProtocol = MainWorker(), output: MainSceneOutputProtocol? = nil) {
        self.worker = worker
        self.output = output
    }
    
    func getRates(request: MainModels.GetRates.Request) {
        
        worker.fetchRates(for: .usd, from: Date(), to: Date()) { [unowned self] (bpi, error) in
            if let error = error {
                self.presentError(error)
            } else {
                self.cachedBpi = bpi
                self.presentRates()
            }
        }
    }
    
    func selectRate(request: MainModels.SelectRate.Request) {
        let index = request.index
        guard let bpi = cachedBpi?.bpis[index] else { return }
        selectedBpi = CurrencyDto.init(date: bpi.date, values: [CurrencyValue.init(type: .usd, value: bpi.rate)])
        output?.displaySelectRate(viewModel: MainModels.SelectRate.ViewModel())
    }
    
    private func presentRates() {
        let displayed: [MainModels.GetRates.Displayed] = self.cachedBpi?.bpis.map({MainModels.GetRates.Displayed(date: $0.date.toString(with: DateFormat.displayed), value: "\($0.rate) $")}) ?? []
        let viewModel = MainModels.GetRates.ViewModel.init(data: displayed)
        output?.displayRates(viewModel: viewModel)
    }
    
    private func presentError(_ error: Swift.Error) {
        output?.displayError(viewModel: MainModels.Error.ViewModel.init(title: "Error", message: error.localizedDescription))
    }
}
