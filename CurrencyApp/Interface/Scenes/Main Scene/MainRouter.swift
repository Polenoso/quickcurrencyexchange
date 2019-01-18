//
//  MainRouter.swift
//  CurrencyApp
//
//  Created by Aitor Pagán on 18/01/2019.
//  Copyright © 2019 polenoso. All rights reserved.
//

import Foundation

protocol MainSceneNavigationProtocol {
    func navigateToDetail()
}

protocol MainSceneDataPassing {
    var dataStore: MainSceneDataStore? { get set }
}

final class MainRouter: MainSceneNavigationProtocol, MainSceneDataPassing {
    
    var dataStore: MainSceneDataStore?
    weak var viewController: MainViewController?
    
    func navigateToDetail() {
        let detailVC = DetailRateViewController()
        detailVC.router?.dataStore?.currencyDto = dataStore?.selectedBpi
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
