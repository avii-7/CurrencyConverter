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
        if let appId: String = try? Configuration.appId.value() {
          return [URLQueryItem(name: "app_id", value: appId)]
        }
        return nil
    }
}

    

