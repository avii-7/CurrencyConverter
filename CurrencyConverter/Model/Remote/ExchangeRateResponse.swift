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
    
    let rates: [CurrencyResponse]
    
    enum CodingKeys: CodingKey {
        case disclaimer
        case license
        case timestamp
        case base
        case rates
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.disclaimer = try container.decode(String.self, forKey: .disclaimer)
        self.license = try container.decode(String.self, forKey: .license)
        self.timestamp = try container.decode(Date.self, forKey: .timestamp)
        self.base = try container.decode(String.self, forKey: .base)
        let ratesDictionary = try container.decode([String: Decimal].self, forKey: .rates)
        self.rates = ratesDictionary.map { CurrencyResponse(code: $0, baseAmount: $1) }
    }
}

struct CurrencyResponse: Decodable {
    let code: String
    let baseAmount: Decimal
}
