//
//  ExchangeRates.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import Foundation

struct ExchangeRates {
    
    let baseCurrency: String
    
    var rates: [Currency]
    
    init(baseCurrency: String, rates: [Currency]) {
        self.baseCurrency = baseCurrency
        self.rates = rates
    }
}

struct Currency: Equatable, Identifiable {
    let id: UUID
    let code: String
    let baseAmount: Decimal
    
    init(id: UUID = .init(), code: String, baseAmount: Decimal) {
        self.id = id
        self.code = code
        self.baseAmount = baseAmount
    }
}
