//
//  CurrencyConverterUtility.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import Foundation

struct CurrencyConverterUtility: CurrencyConverter {

    func convert(from currency1: Currency, to currency2: Currency, for amount: Decimal) -> Decimal {
        
        let baseCurrencyPrice = amount / currency1.baseAmount
        var finalPrice = baseCurrencyPrice * currency2.baseAmount
        finalPrice.round(2, .bankers)
        return finalPrice
    }
}
