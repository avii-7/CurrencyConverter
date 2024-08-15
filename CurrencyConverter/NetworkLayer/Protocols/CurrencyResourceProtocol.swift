//
//  CurrencyResourceProtocol.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import Foundation

protocol CurrencyResourceProtocol {
    func getLatestCurrencyRates() async throws -> ExchangeRateResponse
}
