//
//  ExchangeRateResponse.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import Foundation

struct ExchangeRateResponse: Decodable {
    
    let disclaimer: String
    
    let license: String
    
    let timestamp: Date
    
    let base: String
    
    let rates: [String: Double]
}
