//
//  CurrencyStoreProtocol.swift
//  CurrencyApp
//
//  Created by Aitor Pagán on 16/1/19.
//  Copyright © 2019 polenoso. All rights reserved.
//

import Foundation

protocol CurrencyStoreProtocol: class {
    func getBitcoinsRates(from startDate: Date, to endDate: Date, for currencyType: CurrencyType, completionBlock: @escaping (_ bpi:MultipleBPI?, _ error: Swift.Error?) -> ())
}
