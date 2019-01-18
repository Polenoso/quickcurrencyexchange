//
//  DetailRateModels.swift
//  CurrencyApp
//
//  Created by Aitor Pagán on 18/01/2019.
//  Copyright © 2019 polenoso. All rights reserved.
//

import Foundation

enum DetailRateModels {
    
    typealias DisplayedValue = (value: String, symbol: String)
    
    enum GetDetail {
        
        struct Request {}
        
        struct ViewModel {
            
            let title: String
            let values: [DisplayedValue]
        }
    }
    
    enum SingleValue {
        
        struct ViewModel {
            let value: DisplayedValue
        }
    }
    
    enum Loading {
        
        enum Show {
            struct ViewModel {}
        }
        
        enum Hide {
            struct ViewModel {}
        }
    }
}
