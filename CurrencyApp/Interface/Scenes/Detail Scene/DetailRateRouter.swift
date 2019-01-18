//
//  DetailRateRouter.swift
//  CurrencyApp
//
//  Created by Aitor Pagán on 18/01/2019.
//  Copyright © 2019 polenoso. All rights reserved.
//

import Foundation

protocol DetailRateNavigationProtocol {
    
}

protocol DetailRateDataPassing {
    var dataStore: DetailRateDataStore? { get set }
}

final class DetailRateRouter: DetailRateNavigationProtocol, DetailRateDataPassing {
    
    var dataStore: DetailRateDataStore?
    weak var viewController: DetailRateViewController?
    
}
