//
//  ExchangeRateResponse.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import Foundation
import OrderedCollections

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
        
        let ratesDictionary = try container.decode(Dictionary<String, Decimal>.self, forKey: .rates)
        let keys = ratesDictionary.keys.sorted()
        
        self.rates = keys.compactMap({ key in
            if let value = ratesDictionary[key] {
                return CurrencyResponse(code: key, baseAmount: value)
            }
            return nil
        })
    }
}

struct CurrencyResponse: Decodable {
    let code: String
    let baseAmount: Decimal
}
