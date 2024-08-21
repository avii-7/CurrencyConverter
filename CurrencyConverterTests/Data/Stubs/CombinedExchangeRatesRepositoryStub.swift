//
//  CombinedExchangeRatesRepositoryStub.swift
//  CurrencyConverterTests
//
//  Created by Arun on 14/08/24.
//

import Foundation
@testable import CurrencyConverter

class CombinedExchangeRatesRepositoryStub: ExchangeRatesRepository {
    
    var error: ExchangeRateError? = nil
    
    func getAllExchangeRates() async -> Result<ExchangeRates, ExchangeRateError> {
        
        if let error {
            return .failure(error)
        }
        else {
            return .success(ExchangeRates(baseCurrency: "USD", rates: ["USD": 1.0, "INR": 83.936204, "CAD": 1.369639]))
        }
    }
    
//    func saveLastRequestTime(time: Date) { }
    
//    var cache = false
    
//    func getLastRequestTime() -> Date? {
//        
//        if cache {
//            return Calendar.current.date(byAdding: .minute, value: -5, to: Date.now)
//        }
//        else {
//            return Calendar.current.date(byAdding: .minute, value: 20, to: Date.now)
//        }
//    }
    
    func removeExistingCurrencies() { }
    
    func saveCurrencyRates(exchangeRate: ExchangeRateResponse) { }
}
