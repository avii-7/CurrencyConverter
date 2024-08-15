//
//  Double+Extensions.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import Foundation

extension Double {
    
    func rounded(digits: Int) -> Double {
        let multiplier = pow(10.0, Double(digits))
        return (self * multiplier).rounded() / multiplier
    }
}
