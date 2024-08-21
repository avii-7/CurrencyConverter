//
//  ExchangeRateResponse+Extensions.swift
//  CurrencyConverter
//
//  Created by Arun on 17/08/24.
//

import Foundation

extension ExchangeRateResponse {
    
    func convertToDomain() -> ExchangeRates {
        ExchangeRates(
            baseCurrency: self.base,
            rates: self.rates.map({ Currency(code: $0.code, baseAmount: $0.baseAmount) })
        )
    }
}
