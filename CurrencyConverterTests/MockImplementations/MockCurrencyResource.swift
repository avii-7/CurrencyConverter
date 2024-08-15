//
//  MockCurrencyResource.swift
//  CurrencyConverterTests
//
//  Created by Arun on 14/08/24.
//

import Foundation
@testable import CurrencyConverter

class MockCurrencyResource: CurrencyResourceProtocol {
    
    var throwError = false
    
    var didFetchNewRates = false
    
    func getLatestCurrencyRates() async throws -> ExchangeRateResponse {
        didFetchNewRates = true
        if throwError {
            throw NSError(domain: "Mock Error", code: 1, userInfo: nil)
        }
        
        return ExchangeRateResponse(disclaimer: "ABC", license: "", timestamp: .now, base: "USD", rates: ["USD": 1.0, "INR": 83.936204, "CAD": 1.369639])
    }
}
