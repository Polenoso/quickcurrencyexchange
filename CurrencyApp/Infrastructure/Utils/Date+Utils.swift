//
//  Date+Utils.swift
//  CurrencyApp
//
//  Created by Aitor Pagán on 16/1/19.
//  Copyright © 2019 polenoso. All rights reserved.
//

import Foundation

enum DateFormat: String {
    case displayed = "dd MMMM YYYY"
    case network = "YYYY-MM-dd"
}

extension Date {
    
    func toString(with format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
    
    init(with format: DateFormat, from string: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        self = dateFormatter.date(from: string)!
    }
}
