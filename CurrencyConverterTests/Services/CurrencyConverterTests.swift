//
//  CurrencyConverterTests.swift
//  CurrencyConverterTests
//
//  Created by Arun on 14/08/24.
//

import XCTest
@testable import CurrencyConverter

final class CurrencyConverterTests: XCTestCase {
    
    private var sut: CurrencyConverterUtility!
    
    override func setUp() {
        sut = CurrencyConverterUtility()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testUSDToINRConversion() {
        let fromCurrency = Currency(code: "USD", baseAmount: 1)
        let toCurrency = Currency(code: "INR", baseAmount: 83.75585)
        
        let result = sut.convert(from: fromCurrency, to: toCurrency, for: 100)
        XCTAssertEqual(result, 8376.53, accuracy: 1)
    }
    
    func testUSDToCADConversion() {
        let fromCurrency = Currency(code: "USD", baseAmount: 1)
        let toCurrency = Currency(code: "CAD", baseAmount: 1.36176)
        
        let result = sut.convert(from: fromCurrency, to: toCurrency, for: 167)
        XCTAssertEqual(result, 227.25, accuracy: 1)
    }
    
    func testBTCToUSDConversion() {
        let fromCurrency = Currency(code: "AUD", baseAmount: 1.484889)
        let toCurrency = Currency(code: "USD", baseAmount: 1)
        
        let result = sut.convert(from: fromCurrency, to: toCurrency, for: 434)
        XCTAssertEqual(result, 292.49, accuracy: 1)
    }
}
