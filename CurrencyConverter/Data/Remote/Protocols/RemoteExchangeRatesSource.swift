//
//  RemoteExchangeRatesSource.swift.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import Foundation

protocol RemoteExchangeRatesSource: Sendable {
    func getLatestCurrencyRates() async -> Result<ExchangeRates, ExchangeRateError>
}
