//
//  CurrencyConverter.swift
//  CurrencyConverter
//
//  Created by Arun on 18/08/24.
//

import Foundation

protocol CurrencyConverter {
    func convert(from currency1: Currency, to currency2: Currency, for amount: Decimal) -> Decimal
}
