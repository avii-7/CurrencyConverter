//
//  CurrencyConverterUtility.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import Foundation

struct CurrencyConverterUtility: CurrencyConverter {

    func convert(from currency1: Currency, to currency2: Currency, for amount: Double) -> Double {
        
        let baseCurrencyPrice = amount / currency1.amount
        
        let finalPrice = baseCurrencyPrice * currency2.amount
        
        return finalPrice
    }
}
