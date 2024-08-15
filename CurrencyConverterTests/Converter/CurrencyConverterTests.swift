//
//  CurrencyConverterTests.swift
//  CurrencyConverterTests
//
//  Created by Arun on 14/08/24.
//

import XCTest
@testable import CurrencyConverter

final class CurrencyConverterTests: XCTestCase {
    
    private var currencyConverter: CurrencyConverter!
    
    override func setUpWithError() throws {
        currencyConverter = CurrencyConverter(currencies: [
            "USD": 1.0,
            "INR": 83.936204,
            "CAD": 1.369639
        ])
    }
    
    override func tearDownWithError() throws {
        currencyConverter = nil
    }
    
    func testUSDToINRConversion() {
        let result = currencyConverter.convert(from: "USD", to: "INR", for: 100)
        XCTAssertEqual(result, 8393.6204, accuracy: 1)
    }
    
    func testUSDToCADConversion() {
        let result = currencyConverter.convert(from: "USD", to: "CAD", for: 100)
        XCTAssertEqual(result, 136.9639, accuracy: 1)
    }
    
    func testNonExistentCurrency() {
        let result = currencyConverter.convert(from: "XYZ", to: "INR", for: 100)
        XCTAssertEqual(result, 0)
    }
}
