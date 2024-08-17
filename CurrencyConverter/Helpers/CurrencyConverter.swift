//
//  CurrencyConverterUtility.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import Foundation

struct CurrencyConverter {
    
    private var currencies = [String: Double]()
    
    init(currencies: [String : Double] = [String: Double]()) {
        self.currencies = currencies
    }
    
    func convert(from currency1: String, to currency2: String, for amount: Double) -> Double {
        
        // Convert currency1 to baseCurrency price:
        
        guard let currency1basePrice = currencies[currency1] else {
            return 0
        }
        
        let baseCurrencyPrice = amount / currency1basePrice
        
        guard let currency2basePrice = currencies[currency2] else {
            return 0
        }
        
        let finalPrice = baseCurrencyPrice * currency2basePrice
        
        return finalPrice
    }
}
