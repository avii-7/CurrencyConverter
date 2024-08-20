//
//  Configuration.swift
//  CurrencyConverter
//
//  Created by Arun on 20/08/24.
//

import Foundation

enum ConfigurationError: Error, LocalizedError {
    
    case missingKey, invalidValue
    
    var errorDescription: String? {
        switch self {
        case .missingKey:
            "error ! key is missing"
        case .invalidValue:
            "error ! invalid value"
        }
    }
}

enum Configuration: String {
    // API Keys
    case appId = "APP_ID"
}

extension Configuration {
    
    func value<T>() throws -> T {
        guard let result = Bundle.main.object(forInfoDictionaryKey: self.rawValue) else {
            throw ConfigurationError.missingKey
        }
        
        if let value = result as? T {
            return value
        }
        else {
            throw ConfigurationError.invalidValue
        }
    }
}
