//
//  MainWorker.swift
//  CurrencyApp
//
//  Created by Aitor Pagán on 16/1/19.
//  Copyright © 2019 polenoso. All rights reserved.
//

import Foundation

protocol MainSceneWorkerProtocol {
    func fetchRates(for type: CurrencyType, from: Date, to: Date, completionBlock: @escaping (MultipleBPI?, Swift.Error?) -> ())
}

final class MainWorker: MainSceneWorkerProtocol {
    
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
