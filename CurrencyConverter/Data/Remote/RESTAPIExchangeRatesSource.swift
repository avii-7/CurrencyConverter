//
//  RESTAPIExchangeRatesSource.swift
//  CurrencyConverter
//
//  Created by Arun on 17/08/24.
//

import Foundation

class RESTAPIExchangeRatesSource: RemoteExchangeRatesSource {
    
    func getLatestCurrencyRates() async -> Result<ExchangeRates, ExchangeRateError> {
        do {
            let request = ExchangeRateAPIRequest.latest
            let response: ExchangeRateResponse = try await HttpUtility.shared.hit(request)
            return .success(response.convertToDomain())
        }
        catch {
            return .failure(.remoteData(description: error.localizedDescription))
        }
    }
}
