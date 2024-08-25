//
//  ExchangeRates+Extension.swift
//  CurrencyConverterTests
//
//  Created by Arun on 25/08/24.
//

import Foundation
@testable import CurrencyConverter

extension ExchangeRates {
    
    static func testGetLocal() -> ExchangeRates {
        let rates = [
            Currency(code: "USD", baseAmount: 1.0),
            Currency(code: "INR", baseAmount: 83.936204),
            Currency(code: "CAD", baseAmount: 1.369639)
        ]
        return ExchangeRates(baseCurrency: "USD", rates: rates)
    }
    
    static func testGetRemote() -> ExchangeRates {
        let rates = [
            Currency(code: "INR", baseAmount: 83.936204),
            Currency(code: "CAD", baseAmount: 1.369639),
            Currency(code: "USD", baseAmount: 1.0),
        ]
        return ExchangeRates(baseCurrency: "INR", rates: rates)
    }
}
