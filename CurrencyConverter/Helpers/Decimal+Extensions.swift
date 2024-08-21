//
//  Decimal+Extensions.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import Foundation

extension Decimal {
    
    mutating func round(_ scale: Int, _ roundingMode: NSDecimalNumber.RoundingMode) {
        var localCopy = self
        NSDecimalRound(&self, &localCopy, scale, roundingMode)
    }
}


