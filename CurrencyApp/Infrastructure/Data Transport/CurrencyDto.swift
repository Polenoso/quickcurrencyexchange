//
//  CurrencyDto.swift
//  CurrencyApp
//
//  Created by Aitor Pagán on 18/01/2019.
//  Copyright © 2019 polenoso. All rights reserved.
//

import Foundation

struct CurrencyValue {
    let type: CurrencyType
    let value: Double
}

struct CurrencyDto {
    
    let date: Date
    let values: [CurrencyValue]
}
