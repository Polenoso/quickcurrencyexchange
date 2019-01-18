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
}

protocol MainSceneInputProtocol {
    func getRates(request: MainModels.GetRates.Request)
}

final class MainPresenter: MainSceneInputProtocol {
    
    private var worker: MainSceneWorkerProtocol
    
    var output: MainSceneOutputProtocol?
    
    private var cachedBpi: MultipleBPI?
    
    init(worker: MainSceneWorkerProtocol = MainWorker(), output: MainSceneOutputProtocol? = nil) {
        self.worker = worker
        self.output = output
    }
    
    func getRates(request: MainModels.GetRates.Request) {
        
        worker.fetchRates(for: .usd, from: Date(), to: Date()) { [unowned self] (bpi) in
            self.cachedBpi = bpi
            self.presentRates()
        }
    }
    
    private func presentRates() {
        let displayed: [MainModels.GetRates.Displayed] = self.cachedBpi?.bpis.map({MainModels.GetRates.Displayed(date: $0.date.toString(with: DateFormat.displayed), value: "\($0.rate) $")}) ?? []
        let viewModel = MainModels.GetRates.ViewModel.init(data: displayed)
        output?.displayRates(viewModel: viewModel)
    }
}
