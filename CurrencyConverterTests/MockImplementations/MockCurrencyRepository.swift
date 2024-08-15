//
//  MockCurrencyRepository.swift
//  CurrencyConverterTests
//
//  Created by Arun on 14/08/24.
//

import Foundation
@testable import CurrencyConverter

class MockCurrencyRepository: CurrencyRepository {
    
    var cache = false
    
    func saveLastRequestTime(time: Date) { }
    
    func getLastRequestTime() -> Date? {
        
        if cache {
            return Calendar.current.date(byAdding: .minute, value: -5, to: Date.now)
        }
        else {
            return Calendar.current.date(byAdding: .minute, value: 20, to: Date.now)
        }
    }
    
    func removeExistingCurrencies() { }
    
    func saveCurrencyRates(exchangeRate: ExchangeRateResponse) { }
    
    func getExchangeRates() -> ExchangeRates? {
        return ExchangeRates(baseCurrency: "USD", rates: ["USD": 1.0, "INR": 83.936204, "CAD": 1.369639])
    }
}
