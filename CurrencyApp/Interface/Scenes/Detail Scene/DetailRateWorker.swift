//
//  DetailRateWorker.swift
//  CurrencyApp
//
//  Created by Aitor Pagán on 18/01/2019.
//  Copyright © 2019 polenoso. All rights reserved.
//

import Foundation

protocol DetailRateWorkerProtocol {
    func fetchRates(for type: CurrencyType, from: Date, to: Date, completionBlock: @escaping (MultipleBPI?, Swift.Error?) -> ())
}

final class DetailRateWorker: DetailRateWorkerProtocol {
    
    private var currencyStore: CurrencyStoreProtocol
    
    init(with store: CurrencyStoreProtocol = CurrencyNetworkStore()) {
        self.currencyStore = store
    }
    
    func fetchRates(for type: CurrencyType, from: Date, to: Date, completionBlock: @escaping (MultipleBPI?, Swift.Error?) -> ()) {
        
        currencyStore.getBitcoinsRates(from: from, to: to, for: type) { (bpis, error) in
            DispatchQueue.main.async {
                completionBlock(bpis, error)
            }
        }
    }
}
