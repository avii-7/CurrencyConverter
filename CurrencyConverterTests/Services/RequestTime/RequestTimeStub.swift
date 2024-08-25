//
//  RequestTimeStub.swift
//  CurrencyConverterTests
//
//  Created by Arun on 25/08/24.
//

import Foundation
@testable import CurrencyConverter

class RequestTimeStub: RequestTime {
    
    var error: ExchangeRateError?
    
    var dateType = DateType.now
    
    func getLastRequestTime(for entity: RequestTimeEntity) async -> Result<Date?, ExchangeRateError> {
        if let error {
            return .failure(error)
        }
        
        let date: Date?
        
        switch dateType {
        case .notAvailable:
            date = nil
        case .now:
            date = .now
        case .past:
            date = Date.distantPast
        case .future:
            date = Date.distantFuture
        }
        
        return .success(date)
    }
    
    func saveLastRequestTime(for entity: RequestTimeEntity, date: Date) async -> Result<Void, ExchangeRateError> {
        if let error {
            return .failure(error)
        }
        
        return .success(())
    }
}

enum DateType {
    case notAvailable, now, past, future
}


