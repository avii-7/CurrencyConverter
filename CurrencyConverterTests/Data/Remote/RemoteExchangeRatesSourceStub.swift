//
//  RemoteExchangeRatesSourceStub.swift
//  CurrencyConverterTests
//
//  Created by Arun on 25/08/24.
//

import Foundation
@testable import CurrencyConverter

class RemoteExchangeRatesSourceStub: RemoteExchangeRatesSource {
    
    var error: ExchangeRateError? = nil
    
    func getLatestCurrencyRates() async -> Result<ExchangeRates, ExchangeRateError> {
        if let error {
            return .failure(error)
        }
        
        return .success(ExchangeRates.testGetRemote())
    }
}
