//
//  ExchangeRateEntity+Extensions.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import Foundation

extension ExchangeRateEntity {
    
    func convertToDomain() -> ExchangeRates {
        
        guard let rates = self.currencies else {
            return ExchangeRates(baseCurrency: baseCurrency ?? "", rates: [])
        }
        
        let ratesArray = rates.map { entity in
            return Currency(code: entity.code, baseAmount: entity.baseAmount.decimalValue)
        }
        
        return ExchangeRates(baseCurrency: baseCurrency ?? "", rates: ratesArray)
    }
}
