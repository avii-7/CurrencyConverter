//
//  RequestTimeEnum.swift
//  CurrencyConverter
//
//  Created by Arun on 17/08/24.
//

import Foundation

enum RequestTimeEntity: String {
    case exchangeRates = "lastExchangeRateRequestTime"
}

enum RequestTimeError : Error, LocalizedError {
    case failed(description: String)
    
    // Check weahter i needed or not.
    var errorDescription: String? {
        switch self {
        case .failed(let description):
            return description
        }
    }
}
