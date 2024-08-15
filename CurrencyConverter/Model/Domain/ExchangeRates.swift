//
//  ExchangeRates.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import Foundation

class ExchangeRates {
    
    let baseCurrency: String
    
    var rates: [String: Double]
    
    init(baseCurrency: String = "", rates: [String : Double] = [String: Double]()) {
        self.baseCurrency = baseCurrency
        self.rates = rates
    }
}
