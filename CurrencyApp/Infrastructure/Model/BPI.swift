//
//  BPI.swift
//  CurrencyApp
//
//  Created by Aitor Pagán on 16/1/19.
//  Copyright © 2019 polenoso. All rights reserved.
//

import Foundation

struct MultipleBPI: Decodable {
    
    var bpis: [SimpleCurrency]
    
    private struct CodingKeys: CodingKey {
        var intValue: Int?
        var stringValue: String
        
        init?(intValue: Int) { self.intValue = intValue; self.stringValue = "\(intValue)" }
        init?(stringValue: String) { self.stringValue = stringValue }
    }
    
    public init(from decoder: Decoder) throws {
        bpis = []
        let container = try decoder.container(keyedBy: CodingKeys.self)
        for key in container.allKeys {
            let currency = try container.decode(SimpleCurrency.self, forKey: key)
            bpis.append(currency)
        }
    }
}
