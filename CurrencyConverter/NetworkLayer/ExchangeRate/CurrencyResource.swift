//
//  CurrencyResource.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import Foundation

class CurrencyResource: CurrencyResourceProtocol {
    
    func getLatestCurrencyRates() async throws -> ExchangeRateResponse {
        
        let request = ExchangeRateAPIRequest.latest
        
        let response: ExchangeRateResponse? = try await HttpUtility.shared.hit(request)
        
        if let response {
            return response
        }
        
        throw URLError(.badServerResponse)
    }
}
