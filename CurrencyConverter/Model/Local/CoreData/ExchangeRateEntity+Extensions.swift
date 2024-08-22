//
//  ExchangeRateEntity+Extensions.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import Foundation
import OrderedCollections

extension ExchangeRateEntity {
    
    func convertToDomain() -> ExchangeRates {
        
        guard let rates = self.currencies else {
            return ExchangeRates(baseCurrency: baseCurrency ?? "", rates: [])
        }

        let ratesArray = rates.compactMap { entity in
            if let currencyEntity = entity as? CurrencyEntity {
                return Currency(code: currencyEntity.code, baseAmount: currencyEntity.baseAmount.decimalValue)
            }
            return nil
        }
        
        return ExchangeRates(baseCurrency: baseCurrency ?? "", rates: ratesArray)
    }
}
