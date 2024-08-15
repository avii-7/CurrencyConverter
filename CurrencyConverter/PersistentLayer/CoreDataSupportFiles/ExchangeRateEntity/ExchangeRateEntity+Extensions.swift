//
//  ExchangeRateEntity+Extensions.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import Foundation

extension ExchangeRateEntity {
    
    func convertToDomain() -> ExchangeRates {
        
        let baseCurrency: String
        
        if let bcurrency = self.baseCurrency {
            baseCurrency = bcurrency
        }
        else {
            baseCurrency = ""
        }
        
        guard
            let rates = self.exchangeRates,
            let ratesDictionary = try? JSONSerialization.jsonObject(with: rates, options: []) as? [String: Double] else {
            return ExchangeRates(baseCurrency: baseCurrency)
        }

        return ExchangeRates(baseCurrency: baseCurrency, rates: ratesDictionary)
    }
}
