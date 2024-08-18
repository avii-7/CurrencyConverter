//
//  CurrencyConverter.swift
//  CurrencyConverter
//
//  Created by Arun on 18/08/24.
//

import Foundation

struct Currency {
    let code: String
    let amount: Double
}

protocol CurrencyConverter {
    func convert(from currency1: Currency, to currency2: Currency, for amount: Double) -> Double
}
