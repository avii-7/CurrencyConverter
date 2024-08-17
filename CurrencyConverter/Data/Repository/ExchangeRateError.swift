//
//  ExchangeRateError.swift
//  CurrencyConverter
//
//  Created by Arun on 17/08/24.
//

import Foundation

enum ExchangeRateError : Error, LocalizedError {
    
    case localData(description: String)
    case remoteData(description: String)
    case requestTime(description: String)
    
    var errorDescription: String? {
        switch self {
        case .localData(let description):
            return description
        case .remoteData(let description):
            return description
        case .requestTime(let description):
            return description
        }
    }
}
