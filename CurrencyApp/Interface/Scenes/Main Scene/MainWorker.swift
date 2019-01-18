//
//  MainWorker.swift
//  CurrencyApp
//
//  Created by Aitor Pagán on 16/1/19.
//  Copyright © 2019 polenoso. All rights reserved.
//

import Foundation

protocol MainSceneWorkerProtocol {
    func fetchRates(for type: CurrencyType, from: Date, to: Date, completionBlock:(MultipleBPI) -> ())
}

final class MainWorker: MainSceneWorkerProtocol {
    
    private var currencyStore: CurrencyStoreProtocol
    
    init(with store: CurrencyStoreProtocol = CurrencyMockStore()) {
        self.currencyStore = store
    }
    
    func fetchRates(for type: CurrencyType, from: Date, to: Date, completionBlock: (MultipleBPI) -> ()) {
        
        currencyStore.getBitcoinsRates(from: from, to: to, for: type) { (bpis) in
            completionBlock(bpis)
        }
    }
}
