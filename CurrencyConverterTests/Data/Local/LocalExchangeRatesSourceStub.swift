//
//  LocalExchangeRatesSourceStub.swift
//  CurrencyConverterTests
//
//  Created by Arun on 25/08/24.
//

import Foundation
@testable import CurrencyConverter

class LocalExchangeRatesSourceStub: LocalExchangeRatesSource {
    
    var throwGet: ExchangeRateError? = nil
    
    var throwSave: ExchangeRateError? = nil
    
    var throwRemove: ExchangeRateError? = nil
    
    var shouldReturnExchangeRates = true
    
    func getExchangeRates() async -> Result<ExchangeRates?, ExchangeRateError> {
        if let throwGet {
            return .failure(throwGet)
        }
        
        if shouldReturnExchangeRates {
            return .success(ExchangeRates.testGetLocal())
        }
        
        return .success(nil)
    }
    
    func saveExchangeRates(exchangeRates: ExchangeRates) async -> Result<Void, ExchangeRateError> {
        if let throwSave {
            return .failure(throwSave)
        }
        
        return .success(())
    }
    
    func removeExchangeRates() async -> Result<Void, ExchangeRateError> {
        if let throwRemove {
            return .failure(throwRemove)
        }
        
        return .success(())
    }
}
