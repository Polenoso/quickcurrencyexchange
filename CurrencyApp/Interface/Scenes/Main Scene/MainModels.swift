//
//  MainModels.swift
//  CurrencyApp
//
//  Created by Aitor Pagán on 16/1/19.
//  Copyright © 2019 polenoso. All rights reserved.
//

import Foundation

enum MainModels {
    
    enum GetRates {
        
        struct Request {
            
        }
        
        typealias Displayed = (date: String, value: String)
        
        struct ViewModel {
            let data: [Displayed]
        }
    }
}
