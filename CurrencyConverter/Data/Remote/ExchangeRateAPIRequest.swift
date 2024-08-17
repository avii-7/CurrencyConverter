//
//  ExchangeRateAPIRequest.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import Foundation

enum ExchangeRateAPIRequest {
    case latest
}

extension ExchangeRateAPIRequest : RestAPIRequest {
    
    var httpMethod: HTTPMethod {
        switch self {
        case .latest:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .latest:
            return "latest.json"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        [URLQueryItem(name: "app_id", value: "74e2b51314ad43748a7bd32216a13b63")]
    }
}

    

