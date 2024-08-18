//
//  ExchangeRateEntity+Extensions.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import Foundation

extension ExchangeRateEntity {
    
    func convertToDomain() -> ExchangeRates {
        guard
            let rates = self.exchangeRates,
            let ratesDictionary = try? JSONSerialization.jsonObject(with: rates, options: []) as? [String: Double] else {
            return ExchangeRates(baseCurrency: baseCurrency ?? "", rates: [:])
        }

        return ExchangeRates(baseCurrency: baseCurrency ?? "", rates: ratesDictionary)
    }
}
