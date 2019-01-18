//
//  CurrencyNetworkStore.swift
//  CurrencyApp
//
//  Created by Aitor Pagán on 18/01/2019.
//  Copyright © 2019 polenoso. All rights reserved.
//

import Foundation

final class CurrencyNetworkStore: CurrencyStoreProtocol {
    
    func getBitcoinsRates(from startDate: Date, to endDate: Date, for currencyType: CurrencyType, completionBlock: @escaping (MultipleBPI?, Error?) -> ()) {
        
        Network.shared.getData(type: MultipleBPI.self,with: "bpi", from: "https://api.coindesk.com/v1/bpi/historical/close.json?start=\(startDate.toString(with: .network))&end:\(endDate.toString(with: .network))&currency=\(currencyType.rawValue.uppercased())") { (result) in
            switch result {
            case .success(let mbpi):
                completionBlock(mbpi, nil)
                break
            case .error(let error):
                completionBlock(nil, error)
                break
            }
        }
    }
}
