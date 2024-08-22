//
//  ExchangeRates.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import Foundation

class ExchangeRates {
    
    let baseCurrency: String
    
    var rates: [Currency]
    
    init(baseCurrency: String, rates: [Currency]) {
        self.baseCurrency = baseCurrency
        self.rates = rates
    }
}

struct Currency: Equatable {
    let code: String
    let baseAmount: Decimal
}
