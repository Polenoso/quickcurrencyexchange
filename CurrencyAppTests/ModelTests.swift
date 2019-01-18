//
//  ModelTests.swift
//  CurrencyAppTests
//
//  Created by Aitor Pagán on 16/1/19.
//  Copyright © 2019 polenoso. All rights reserved.
//

import XCTest
@testable import CurrencyApp

class ModelTests: XCTestCase {

    func testReadingMultipleBPIsShouldCreateNSimpleCurrencies() {
        //Given
        let json = "{\"2013-09-01\":128.2597,\"2013-09-02\":127.3648,\"2013-09-03\":127.5915,\"2013-09-04\":120.5738,\"2013-09-05\":120.5333}"
        let data = Data(json.utf8)
        
        //When
        let multipleBpi = try! JSONDecoder().decode(MultipleBPI.self, from: data)
        
        //Then
        XCTAssertTrue(multipleBpi.bpis.count == 5)
    }

}
