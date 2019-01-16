//
//  Currency.swift
//  CurrencyApp
//
//  Created by Aitor Pagán on 16/1/19.
//  Copyright © 2019 polenoso. All rights reserved.
//

import Foundation

struct SimpleCurrency: Decodable {
    let date: Date
    let rate: Double
    
    init(date: Date, rate: Double) {
        self.date = date
        self.rate = rate
    }
    
    private struct CodingKeys: CodingKey {
        var intValue: Int?
        var stringValue: String
        
        init?(intValue: Int) { self.intValue = intValue; self.stringValue = "\(intValue)" }
        init?(stringValue: String) { self.stringValue = stringValue }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.rate = try container.decode(Double.self)
        let stringDate = (container.codingPath.first?.stringValue)!
        self.date = Date(with: .network, from: stringDate)
    }
}
